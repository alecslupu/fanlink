class CreateRewardProgress < ActiveRecord::Migration[5.1]
  def change
    create_table :reward_progresses do |t|
      t.integer :reward_id, null: false
      t.integer :person_id, null: false
      t.text :series, default: nil
      t.jsonb :actions, default: {}, null: false
      t.integer :total, default: 0, null: false
      t.timestamps null: false
    end
  end
end
