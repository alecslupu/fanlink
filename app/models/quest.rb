class Quest < ApplicationRecord
    include AttachmentSupport
    include TranslationThings

    enum status: %i[ disabled enabled active deleted ]

    belongs_to :product
    
    has_image_called :picture
    # has_manual_translated :description, :name
    
    has_many :quest_activities

    accepts_nested_attributes_for :quest_activities

    acts_as_tenant(:product)

    has_paper_trail

    validate :date_sanity
    validates :name, presence: { message: "Name is required." }
    validates :description, presence: { message: "A description is required." }
    validates :starts_at, presence: { message: "Starting date and time is required." }

    scope :in_date_range, -> (start_date, end_date) {
        where("quests.starts_at >= ? and quests.ends_at <= ?",
          start_date.beginning_of_day, end_date.end_of_day)
      }
    
    scope :for_product, -> (product) { includes(:product).where(roduct: product) } 


private

    def date_sanity
        if ends_at.present? && ends_at < starts_at
          errors.add(:ends_at, "cannot be before starts at.")
        end
    end

end