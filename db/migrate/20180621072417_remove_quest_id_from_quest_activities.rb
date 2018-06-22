class RemoveQuestIdFromQuestActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :quest_activities, :quest_id, :integer
  end
end
