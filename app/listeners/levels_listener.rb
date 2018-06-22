class LevelsListener
  include Wisper::Publisher
  include RealTimeHelpers

  def self.award_points(user, payload)
    puts "Got points!"
    @progress = LevelProgress.find_or_initialize_by(person_id: user.id)
    @progress.points[payload["source"]] ||= 0
    @progress.points[payload["source"]] += payload["points"]
    @progress.total ||= 0
    @progress.total += payload["points"]
    @progress.save
  end
end
