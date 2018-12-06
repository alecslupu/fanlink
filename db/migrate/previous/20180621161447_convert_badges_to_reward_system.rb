class ConvertBadgesToRewardSystem < ActiveRecord::Migration[5.1]
  def up
    Badge.all.each do |b|
      reward = Reward.create(product_id: b.product_id, name:  b.name, internal_name: b.internal_name, reward_type: Reward.reward_types['badge'], reward_type_id: b.id, completion_requirement: b.action_requirement, points: b.point_value)
      if reward.valid?
        AssignedReward.create(reward_id: reward.id, assigned_type: "ActionType", assigned_id: b.action_type_id)
      end
    end
  end

  def down
  end
end
