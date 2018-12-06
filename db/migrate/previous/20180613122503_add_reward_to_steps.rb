class AddRewardToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :reward_id, :integer, default: nil
    add_index :steps, [:reward_id], name: "idx_steps_rewards"
    add_foreign_key :steps, :rewards, name: "fk_steps_rewards"
  end
  
end
