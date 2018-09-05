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

  has_many :rewards, through: :assigned_rewards

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


private

  def date_sanity
    if ends_at.present? && ends_at < starts_at
      errors.add(:ends_at, _("Start date cannot be after end date."))
    end
  end
end
