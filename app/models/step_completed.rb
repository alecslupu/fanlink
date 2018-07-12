class StepCompleted < ApplicationRecord

    enum status: %i[ locked unlocked completed ]

    belongs_to :step
    belongs_to :person


private

end
