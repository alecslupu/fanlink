# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id                       :bigint           not null, primary key
#  product_id               :integer          not null
#  name_text_old            :text
#  created_by_id            :integer
#  status                   :integer          default("inactive"), not null
#  public                   :boolean          default(FALSE), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  picture_file_name        :string
#  picture_content_type     :string
#  picture_file_size        :integer
#  picture_updated_at       :datetime
#  untranslated_name        :jsonb            not null
#  untranslated_description :jsonb            not null
#  order                    :integer          default(0), not null
#  last_message_timestamp   :bigint           default(0)
#

class Room < ApplicationRecord
  # include Room::RealTime

  # old Room::RealTime
  def clear_message_counter(membership)
    ClearMessageCounterJob.perform_later(id, membership.id)
  end

  def delete_me(version = 0)
    DeleteRoomJob.perform_later(id, version) if private?
  end

  def post(version = 0)
    # TODO: this does not make any sense
    PostMessageJob.perform_later(id, version)
  end

  def increment_message_counters(poster_id, version = 0)
    room_memberships.each do |mem|
      mem.increment!(:message_count) unless mem.person.id == poster_id
    end
    UpdateMessageCounterJob.perform_later(id, poster_id, version)
  end

  def new_room(version = 0)
    AddRoomJob.perform_later(id, version) if private?
  end
  # eof old Room::RealTime

  # replicated_model

  enum status: { inactive: 0, active: 1, deleted: 2 }

  acts_as_tenant(:product)
  scope :for_product, ->(product) { where(rooms: { product_id: product.id }) }

  belongs_to :created_by, class_name: 'Person', optional: true
  belongs_to :product

  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  has_one_attached :picture

  validates :picture, size: { less_than: 5.megabytes },
                      content_type: { in: %w[image/jpeg image/gif image/png] }

  def picture_url
    ActiveSupport::Deprecation.warn('Room#picture_url is deprecated')
    AttachmentPresenter.new(picture).url
  end

  def picture_optimal_url
    ActiveSupport::Deprecation.warn('Room#picture_optimal_url is deprecated')
    AttachmentPresenter.new(picture).optimal_url
  end

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

  validate :picture_validation

  scope :privates_for_person, lambda { |member|
    joins(:room_memberships)
      .where('room_memberships.person_id = ? and rooms.public = ?', member.id, false)
      .order(updated_at: :desc)
  }
  scope :publics, -> { where(public: true).order(updated_at: :desc) }
  scope :privates, -> { where(public: false) }

  def is_member?(person)
    members.include?(person)
  end

  def private?
    !public
  end

  private

  def picture_validation
    if picture.attached?
      errors.add(:picture, 'Private rooms may not have pictures.') if private?
    end
  end
end
