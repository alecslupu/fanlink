class ChangeFieldsForQuestActivity < ActiveRecord::Migration[5.1]
  def change
    rename_column :quest_activities, :requires, :beacon
  end
end
