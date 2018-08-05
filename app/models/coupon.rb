class Coupon < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_many :rewards, -> { where("rewards.reward_type = ?", Reward.reward_types["coupon"]) }, foreign_key: "reward_type_id"

  normalize_attributes :url
end
