class AddLevelProgressFromPersonRewards < ActiveRecord::Migration[5.1]
  def up
    PersonReward.all.each do |pr|
      r = Reward.find(pr.reward_id)
      progress = LevelProgress.find_or_initialize_by(person_id: pr.person_id)
      progress.points[r.reward_type] ||= 0
      progress.points[r.reward_type] += r.points
      progress.total ||= 0
      progress.total += r.points
      progress.save
    end

  end

  def down

  end
end
