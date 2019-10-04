Reward.find_each do |reward|
  AssignedReward.create!(
    reward: reward.id,
    assigned_id: reward.badge_id,
    assigned_type: "ActionType",
    max_times: 1
  )
end
