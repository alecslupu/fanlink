class RewardsListener
  include RealTimeHelpers

  def self.reward_progress_created(user, progress)
    if progress.total >= progress.reward.completion_requirement
      reward = PersonReward.find_or_initialize_by(person_id: user.id, reward_id: progress.reward.id, source: "reward")
      if reward.valid?
        reward.save
        if progress.reward.points > 0
          LevelsListener.award_points(user, {"points" => progress.reward.points, "source" => progress.reward.reward_type})
        end
      end
    end
  end
end