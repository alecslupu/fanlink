class QuestCompletion < ApplicationRecord
  include QuestCompletion::PortalFilters

  enum status: %i[ locked unlocked completed ]

  belongs_to :step, touch: true
  belongs_to :person, touch: true
  belongs_to :quest_activity, foreign_key: "activity_id"

  validates :person_id, presence: { message: "Person ID is not being automatically set." }
  validates :activity_id, presence: { message: "Activity ID is required." }

  # default_scope { order(created_at: :desc) }
  scope :count_activity, -> (step_id) { where(step_id: step_id).count }

private
end
