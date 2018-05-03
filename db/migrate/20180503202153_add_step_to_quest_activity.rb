class AddGroupToQuestActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :step, :integer
  end
end
