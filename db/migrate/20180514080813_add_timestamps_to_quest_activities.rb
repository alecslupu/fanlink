class AddTimestampsToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    change_table(:quest_activities) { |t| t.timestamps }
  end
end
