class QuestCompletion < ApplicationRecord
    include QuestCompletion::PortalFilters
    include Wisper::Publisher

    belongs_to :quest
    belongs_to :person
    belongs_to :quest_activity, :foreign_key => "activity_id"

    validates :quest_id, presence: { message: "Quest ID is not being automatically set." }
    validates :person_id, presence: { message: "Person ID is not being automatically set." }
    validates :activity_id, presence: { message: "Activity ID is required." }

private

end