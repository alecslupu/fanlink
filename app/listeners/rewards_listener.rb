class RewardsListener
  include RealTimeHelpers

  def self.reward_progress_created(user, progress, series_total = nil)
    series_total = progress.total unless series_total.present?
    if series_total >= progress.reward.completion_requirement
      rewarded = PersonReward.where(person_id: user.id, reward_id: progress.reward.id, source: "reward")
      if !rewarded.exists?
        reward = PersonReward.create(person_id: user.id, reward_id: progress.reward.id, source: "reward")
        if reward.valid?
          reward.save
          if progress.reward.points > 0
            LevelsListener.award_points(user, {"points" => progress.reward.points, "source" => progress.reward.reward_type})
          end
        end
      end
    end
  end
end
