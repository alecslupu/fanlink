class AddTitleToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :title, :jsonb, default: {}, null: false
  end
end
