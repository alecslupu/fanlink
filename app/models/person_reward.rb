class PersonReward < ApplicationRecord
    belongs_to :reward
    belongs_to :person
end
