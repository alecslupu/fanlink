class CreateStepCompleted < ActiveRecord::Migration[5.1]
  def up
    create_table :step_completed do |t|
      t.integer :step_id, null: false
      t.integer :person_id, null: false
      t.text :status, default: 0, null: false
    end

    add_column :step_completed, :quest_id, :integer, null: false
    add_column :step_completed, :created_at, :datetime, null: false
    add_column :step_completed, :updated_at, :datetime, null: false
    add_index :step_completed, :step_id, name: "idx_step_completed_step"
    add_index :step_completed, :quest_id, name: "idx_step_completed_quest"
    add_index :step_completed, :person_id, name: "idx_step_completed_person"
    add_foreign_key :step_completed, :quests, name: "fk_steps_completed_quests"
    add_foreign_key :step_completed, :steps, name: "fk_steps_completed_steps"
    rename_column :step_completed, :status, :status_old
    add_column :step_completed, :status, :integer, default: 0, null: false
  end

  def down
    drop_table :step_completed
  end
end
