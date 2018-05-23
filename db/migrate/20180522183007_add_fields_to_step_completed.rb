class AddFieldsToStepCompleted < ActiveRecord::Migration[5.1]
  def change
    add_column :step_completed, :quest_id, :integer, null: false
    add_column :step_completed, :created_at, :datetime, null: false
    add_column :step_completed, :updated_at, :datetime, null: false
    add_index :step_completed, :step_id, name: "idx_step_completed_step"
    add_index :step_completed, :quest_id, name: "idx_step_completed_quest"
    add_index :step_completed, :person_id, name: "idx_step_completed_person"
    add_foreign_key :step_completed, :quests, name: "fk_steps_completed_quests"
    add_foreign_key :step_completed, :steps, name: "fk_steps_completed_steps"
  end
end
