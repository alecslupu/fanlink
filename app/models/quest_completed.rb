class QuestCompleted < ApplicationRecord

    enum status: %i[ completed ]

    belongs_to :quest
    belongs_to :person


    #default_scope { order(created_at: :desc) }
private

end
