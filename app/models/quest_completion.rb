class QuestCompletion < ApplicationRecord
    belongs_to :quest
    belongs_to :person
    belongs_to :quest_activity
end