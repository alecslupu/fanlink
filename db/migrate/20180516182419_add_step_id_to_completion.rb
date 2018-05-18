class AddStepIdToCompletion < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_completions, :step_id, :integer, null: false
    add_index :quest_completions, :step_id, name: "idx_completions_step"
    add_foreign_key :quest_completions, :steps, name: "fk_completions_steps"
  end
end
