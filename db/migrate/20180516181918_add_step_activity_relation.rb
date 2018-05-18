class AddStepActivityRelation < ActiveRecord::Migration[5.1]
  def change
    remove_column :quest_activities, :step_id
    add_column :quest_activities, :step_id, :integer, null: false
    remove_foreign_key :quest_activities, name: "fk_activities_quests"
    add_foreign_key :quest_activities, :steps, name: "fk_activities_steps"
  end
end
