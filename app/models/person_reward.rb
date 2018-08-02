class PersonReward < ApplicationRecord
  belongs_to :reward
  belongs_to :person, touch: true
end
