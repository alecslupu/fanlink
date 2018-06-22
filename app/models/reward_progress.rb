class RewardProgress < ApplicationRecord
  belongs_to :person
  belongs_to :reward
end
