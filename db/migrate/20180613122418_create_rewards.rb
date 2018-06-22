class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.integer :product_id, null: false
      t.jsonb :name, default: {}, null: false
      t.text :internal_name, null: false
      t.integer :reward_type, default: 0, null: false
      t.integer :reward_type_id, null: false
      t.text :series, default: nil
      t.integer :completion_requirement, default: 1, null: false
      t.integer :points, default: 0
      t.integer :status, default: 0, null: false
      t.boolean :deleted, default: false
      t.timestamps null: false
    end
    add_index :rewards, [:product_id], name: "idx_rewards_product"
    add_index :rewards, [:product_id, :internal_name], name: "unq_rewards_product_internal_name", unique: true
    add_index :rewards, [:reward_type, :reward_type_id], name: "unq_rewards_type_reward_type_id", unique: true
    add_index :rewards, [:product_id, :name], name: "unq_rewards_product_name", unique: true
    add_foreign_key :rewards, :products, name: "fk_rewards_product", on_delete: :cascade
  end
end
