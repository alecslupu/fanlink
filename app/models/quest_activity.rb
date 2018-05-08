class QuestActivity < ApplicationRecord
    belongs_to :quest
    has_many :quest_completions, :foreign_key => "activity_id"
end