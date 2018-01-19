class CreateActionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :action_types do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.integer :seconds_lag, default: 0, null: false
      t.timestamps null: false
    end
    add_index :action_types, [:product_id], name: "idx_action_types_product"
    add_index :action_types, [:product_id, :internal_name], name: "unq_action_types_product_internal_name", unique: true
  end
end
