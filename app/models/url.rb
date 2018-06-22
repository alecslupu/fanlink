class Url < ApplicationRecord
    has_many :rewards, -> { where("rewards.reward_type = ?", Reward.reward_types['url']) }, :foreign_key => "reward_type_id"
end
