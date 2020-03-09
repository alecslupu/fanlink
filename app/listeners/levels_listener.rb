class LevelsListener
  include RealTimeHelpers

  def self.award_points(user, payload)
    @progress = LevelProgress.find_or_initialize_by(person_id: user.id)
    @progress.points[payload["source"]] ||= 0
    @progress.points[payload["source"]] += payload["points"]
    @progress.total ||= 0
    @progress.total += payload["points"]
    @progress.save
    user.touch
  end
end
