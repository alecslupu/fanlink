class Coupon < ApplicationRecord

end
class Coupon < ApplicationRecord
  has_many :rewards, -> { where("rewards.reward_type = ?", Reward.reward_types['coupon']) }, :foreign_key => "reward_type_id"

end
