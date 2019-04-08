# == Schema Information
#
# Table name: quests
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  event_id             :integer
#  name_text_old        :text
#  internal_name        :text             not null
#  description_text_old :text
#  status               :integer          default("active"), not null
#  starts_at            :datetime         not null
#  ends_at              :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  picture_meta         :text
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  reward_id            :integer
#

class Quest < ApplicationRecord
  include AttachmentSupport
  include TranslationThings
  include Quest::PortalFilters

  # enum status: %i[ in_development in_testing published deleted ]
  enum status: %i[ disabled enabled active deleted ]

  acts_as_tenant(:product)
  belongs_to :product

  has_image_called :picture
  # TODO Add translation support
  has_manual_translated :description, :name

  has_many :assigned_rewards, as: :assigned

  has_many :rewards, through: :assigned_rewards #, source: :assigned, source_type: "Quest"

  has_many :steps, -> { order(created_at: :asc) }, dependent: :destroy, inverse_of: :quest
  #   has_many :quest_completions, dependent: :destroy

  accepts_nested_attributes_for :steps

  normalize_attributes :event_id, :ends_at

  has_paper_trail

  validate :date_sanity
  validates :name, presence: { message: _("Name is required.") }
  validates :description, presence: { message: _("A quest description is required.") }
  validates :starts_at, presence: { message: _("Starting date and time is required.") }

  scope :in_date_range, -> (start_date, end_date) {
      where("quests.starts_at >= ? and quests.ends_at <= ?",
        start_date.beginning_of_day, end_date.end_of_day)
    }

  scope :for_product, -> (product) { includes(:product).where(product: product) }
  scope :ordered, -> { includes(:quest_activities).order("quest_activities.created_at DESC") }
  scope :in_testing, -> { where(status: [:enabled, :active]) }
  scope :running, -> { where("quests.starts_at >= ? AND quests.ends_at <= ?", Time.zone.now, Time.zone.now) }

  def running?
    starts_at >= Time.zone.now && (ends_at.nil? || ends_at <= Time.zone.now)
  end


private

  def date_sanity
    if ends_at.present? && ends_at < starts_at
      errors.add(:ends_at, :date_sanity, message: _("Start date cannot be after end date."))
    end
  end
end
