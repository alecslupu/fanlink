class StepCompleted < ApplicationRecord
  enum status: %i[ locked unlocked completed ]

  belongs_to :step, touch: true
  belongs_to :person, touch: true


private
end
