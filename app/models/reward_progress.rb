class RewardProgress < ApplicationRecord
  belongs_to :person, touch: true
  belongs_to :reward

  normalize_attributes :series
end
