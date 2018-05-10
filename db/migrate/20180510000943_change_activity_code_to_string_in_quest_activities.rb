class ChangeActivityCodeToStringInQuestActivities < ActiveRecord::Migration[5.1]
  def change
    change_column :quest_activities, :activity_code, :string, :default => nil
  end
end
