class DropColumnsFromQuestActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :quest_activities, :step
    remove_column :quest_activities, :beacon
    remove_column :quest_activities, :post
    remove_column :quest_activities, :image
    remove_column :quest_activities, :audio
  end
end
