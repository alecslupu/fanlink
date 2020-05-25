# frozen_string_literal: true
# == Schema Information
#
# Table name: rooms
#
#  id                     :bigint(8)        not null, primary key
#  product_id             :integer          not null
#  name_text_old          :text
#  created_by_id          :integer
#  status                 :integer          default("inactive"), not null
#  public                 :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  picture_file_name      :string
#  picture_content_type   :string
#  picture_file_size      :integer
#  picture_updated_at     :datetime
#  name                   :jsonb            not null
#  description            :jsonb            not null
#  order                  :integer          default(0), not null
#  last_message_timestamp :bigint(8)        default(0)
#

class Room < ApplicationRecord

  # old Room::RealTime
  def clear_message_counter(membership)
    ClearMessageCounterJob.perform_later(self.id, membership.id)
  end

  def delete_me(version = 0)
    DeleteRoomJob.perform_later(id, version) if self.private?
  end

  def post(version = 0)
    # TODO this does not make any sense
    PostMessageJob.perform_later(self.id, version)
  end

  def increment_message_counters(poster_id, version = 0)
    room_memberships.each do |mem|
      mem.increment!(:message_count) unless mem.person.id == poster_id
    end
    UpdateMessageCounterJob.perform_later(self.id, poster_id, version)
  end

  def new_room(version = 0)
    AddRoomJob.perform_later(self.id, version) if self.private?
  end
  # eof old Room::RealTime

  # replicated_model

  enum status: %i[ inactive active deleted ]

  acts_as_tenant(:product)
  scope :for_product, -> (product) { where( rooms: { product_id: product.id } ) }

  belongs_to :created_by, class_name: "Person", required: false
  belongs_to :product

  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  # AttachmentSupport
  has_one_attached :picture

  validates :picture, size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png]}

  def picture_url
    picture.attached? ? service_url : nil
  end

  def picture_optimal_url
    opts = {resize_to_limit: [1000, 5000], auto_orient: true, quality: 75}
    picture.attached? ? picture.variant(opts).processed.service_url : nil
  end

  # has_attached_file :picture,
  #   default_url: nil,
  #   styles: {
  #     optimal: "1000x",
  #     thumbnail: "100x100#"
  #   },
  #   convert_options: {
  #     optimal: "-quality 75 -strip"
  #   }
  #
  # validates_attachment :picture,
  #   content_type: {content_type: %w[image/jpeg image/gif image/png]},
  #   size: {in: 0..5.megabytes}
  #
  # def picture_url
  #   picture.file? ? picture.url : nil
  # end
  #
  # def picture_optimal_url
  #   picture.file? ? picture.url(:optimal) : nil
  # end

  # AttachmentSupport
  #
  if Rails.env.staging?
    has_many :messages, dependent: :destroy
  else
    has_many :messages, dependent: :restrict_with_error
  end

  has_many :pin_messages, dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :room_subscribers, dependent: :destroy


  has_many :members, through: :room_memberships, source: :person
  has_many :pin_from, through: :pin_messages, source: :person
  has_many :subscribers, through: :room_subscribers, source: :person

  has_paper_trail

  validates :picture, absence: { message: _("Private rooms may not have pictures.") }, if: Proc.new { |room| room.private? }
  scope :privates_for_person, -> (member) { joins(:room_memberships).where("room_memberships.person_id = ? and rooms.public = ?", member.id, false).order(updated_at: :desc) }
  scope :publics, -> { where(public: true).order(updated_at: :desc) }
  scope :privates, -> { where(public: false) }

  def is_member?(person)
    members.include?(person)
  end

  def private?
    !public
  end
end
