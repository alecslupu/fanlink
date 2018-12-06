class ChangeDefaultValuesForQuestActiviy < ActiveRecord::Migration[5.1]
  def change
    change_column_default :quest_activities, :image, false
    change_column_default :quest_activities, :post, false
    change_column_default :quest_activities, :audio, false
  end
end
