class AddTimestampsToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :created_at, :datetime, default: nil, null: false
    add_column :quest_activities, :updated_at, :datetime, default: nil, null: false
    QuestActivity.update_all({:created_at => Time.now, :updated_at => Time.now})
  end
end
