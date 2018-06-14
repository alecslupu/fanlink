class AddRewardToQuests < ActiveRecord::Migration[5.1]
  def change
    add_column :quests, :reward_id, :integer, default: nil
    add_index :quests, [:reward_id], name: "idx_quests_rewards"
    add_foreign_key :quests, :rewards, name: "fk_quests_rewards"
  end
end
