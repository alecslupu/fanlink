class QuestCompleted < ApplicationRecord

    enum status: %i[ completed ]

    belongs_to :quest
    belongs_to :person


private

end