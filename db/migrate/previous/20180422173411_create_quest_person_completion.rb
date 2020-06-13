class CreateQuestPersonCompletion < ActiveRecord::Migration[5.1]
  def up
    create_table :quest_person_completions do |t|
      t.integer :person_id, null: false
      t.integer :quest_id, null: false
      t.integer :activity_id
    end
    add_index :quest_person_completions, [:person_id], name: "ind_quest_person_completions"
    rename_table :quest_person_completions, :quest_completions
    change_column_null :quest_completions, :activity_id, false
    add_index :quest_completions, [:quest_id], name: "ind_quest_completions"
    change_table(:quest_completions) { |t| t.timestamps }

    add_column :quest_completions, :status, :text, :default => 0, null: false
    QuestCompletion.update_all(:status => 2)
    add_column :quest_completions, :step_id, :integer, null: false
    add_index :quest_completions, :step_id, name: "idx_completions_step"
    add_foreign_key :quest_completions, :steps, name: "fk_completions_steps"
    remove_column :quest_completions, :quest_id

    rename_column :quest_completions, :status, :status_old
    add_column :quest_completions, :status, :integer, default: 0, null: false
  end

  def down
    drop_table :quest_completions
  end
end
