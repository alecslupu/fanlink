class StepCompleted < ApplicationRecord

    enum status: %i[ locked unlocked completed ]

    belongs_to :step
    belongs_to :person
    belongs_to :step


private

end