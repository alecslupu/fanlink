class CreateAssignedRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :assigned_rewards do |t|
      t.integer :reward_id, null: false
      t.integer :assigned_id, null: false
      t.text :assigned_type, null: false
      t.integer :max_times, default: 1, null: false
      t.timestamps null: false
      t.index [:reward_id]
      t.index [:assigned_id, :assigned_type]
    end
  end
end
