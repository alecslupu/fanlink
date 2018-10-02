class Url < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_one :reward, -> { where("rewards.reward_type = ?", Reward.reward_types["url"]) }, foreign_key: "reward_type_id"
  has_many :assigned_rewards, through: :reward
end
