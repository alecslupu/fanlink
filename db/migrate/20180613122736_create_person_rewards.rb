class CreatePersonRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :person_rewards do |t|
      t.integer :person_id, null: false
      t.integer :reward_id, null: false
      t.text :source, null: false
      t.timestamps null: false
      t.boolean :deleted, default: false
    end
  end
end
