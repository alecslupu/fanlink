class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.text :reward_type, null: false
      t.jsonb :type_data, null: false
      t.integer :status, default: 0, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, default: nil
      t.timestamps null: false
    end
    add_index :rewards, [:product_id], name: "idx_rewards_product"
    add_index :rewards, [:product_id, :internal_name], name: "unq_rewards_product_internal_name", unique: true
    add_index :rewards, [:product_id, :name], name: "unq_rewards_product_name", unique: true
    add_foreign_key :rewards, :products, name: "fk_rewards_product", on_delete: :cascade
  end
end
