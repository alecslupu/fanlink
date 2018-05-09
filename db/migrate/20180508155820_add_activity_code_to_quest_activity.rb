class AddActivityCodeToQuestActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :activity_code, :integer
  end
end
