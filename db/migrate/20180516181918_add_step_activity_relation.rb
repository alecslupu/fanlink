class AddStepActivityRelation < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :step_id, :integer, null: false, default: 1
    remove_foreign_key :quest_activities, name: "fk_activities_quests"
    add_foreign_key :quest_activities, :steps, name: "fk_activities_steps"
  end
end
