class ConvertBadgesAwardsToPersonRewards < ActiveRecord::Migration[5.1]
  def up
    BadgeAward.all.each do |ba|
      reward = Reward.where(reward_type: Reward.reward_types['badge'], reward_type_id: ba.badge_id).first
      if !reward.nil?
        PersonReward.create(person_id: ba.person_id, reward_id: reward.id, source: "migration")
      end
    end

  end

  def down

  end
end
