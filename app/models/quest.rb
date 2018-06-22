class Quest < ApplicationRecord
    include AttachmentSupport
    include TranslationThings
    include Quest::PortalFilters

    enum status: %i[ disabled enabled active deleted ]

    belongs_to :product, inverse_of: :quests

    has_image_called :picture
    #TODO Add translation support
    has_manual_translated :description, :name

    has_many :assigned_rewards, inverse_of: :quest

    has_many :rewards, through: :assigned_rewards, inverse_of: :quest

    has_many :steps, -> { order(created_at: :asc) }, dependent: :destroy, inverse_of: :quest
    #   has_many :quest_completions, dependent: :destroy

    accepts_nested_attributes_for :steps

    acts_as_tenant(:product)

    has_paper_trail

    validate :date_sanity
    validates :name, presence: { message: "Name is required." }
    validates :description, presence: { message: "A description is required." }
    validates :starts_at, presence: { message: "Starting date and time is required." }

    #default_scope { order(created_at: :desc) }

    scope :in_date_range, -> (start_date, end_date) {
        where("quests.starts_at >= ? and quests.ends_at <= ?",
          start_date.beginning_of_day, end_date.end_of_day)
      }

    scope :for_product, -> (product) { includes(:product).where(product: product) }
    scope :ordered, -> { includes(:quest_activities).order('quest_activities.created_at DESC') }


private

    def date_sanity
        if ends_at.present? && ends_at < starts_at
          errors.add(:ends_at, "cannot be before starts at.")
        end
    end

end
