class AddRewardToQuestActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_activities, :reward_id, :integer, default: nil
    add_index :quest_activities, [:reward_id], name: "idx_quest_activities_rewards"
    add_foreign_key :quest_activities, :rewards, name: "fk_quest_activities_rewards"
  end
end
