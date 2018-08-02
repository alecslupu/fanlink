class QuestCompleted < ApplicationRecord
  enum status: %i[ completed ]

  belongs_to :quest
  belongs_to :person, touch: true


# default_scope { order(created_at: :desc) }
private
end
