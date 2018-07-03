class RewardProgress < ApplicationRecord
  belongs_to :person
  belongs_to :reward

  normalize_attributes :series
end
