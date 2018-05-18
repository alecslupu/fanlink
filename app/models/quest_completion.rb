class QuestCompletion < ApplicationRecord
    include QuestCompletion::PortalFilters

    enum status: %i[ locked unlocked completed ]

    belongs_to :step
    belongs_to :person
    belongs_to :quest_activity, :foreign_key => "activity_id"

    validates :quest_id, presence: { message: "Quest ID is not being automatically set." }
    validates :person_id, presence: { message: "Person ID is not being automatically set." }
    validates :activity_id, presence: { message: "Activity ID is required." }

    scope :count_activity, -> (step_id) { where(step_id: step_id).count }

private

end