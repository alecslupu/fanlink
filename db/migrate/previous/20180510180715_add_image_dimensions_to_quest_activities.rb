class AddImageDimensionsToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :picture_meta, :text
  end
end
