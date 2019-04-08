# == Schema Information
#
# Table name: rooms
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  name_text_old        :text
#  created_by_id        :integer
#  status               :integer          default("inactive"), not null
#  public               :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  order                :integer          default(0), not null
#

class Room < ApplicationRecord
  include AttachmentSupport
  include Room::RealTime
  include TranslationThings

  #replicated_model

  enum status: %i[ inactive active deleted ]

  acts_as_tenant(:product)

  belongs_to :created_by, class_name: "Person", required: false
  belongs_to :product

  has_manual_translated :description, :name

  has_image_called :picture

  has_many :messages, dependent: :restrict_with_error
  has_many :pin_messages, dependent: :destroy
  has_many :room_memberships, dependent: :destroy


  has_many :members, through: :room_memberships, source: :person
  has_many :pin_from, through: :pin_messages, source: :person

  has_paper_trail

  validates :picture, absence: { message: _("Private rooms may not have pictures.")}, if: Proc.new { |r| !r.public? }
  scope :privates_for_person, -> (member) { joins(:room_memberships).where("room_memberships.person_id = ? and rooms.public = ?", member.id, false) }
  scope :publics, -> { where(public: true) }
  scope :privates, -> { where(public: false) }

  def is_member?(person)
    members.include?(person)
  end

  def private?
    !public
  end
end
