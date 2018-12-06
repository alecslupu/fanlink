class AddImageToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    add_attachment :quest_activities, :picture
  end
end
