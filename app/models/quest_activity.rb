class QuestActivity < ApplicationRecord
    belongs_to :quest

    has_many :quest_activity_requirement
end