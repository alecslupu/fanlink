class CreateActionTypes < ActiveRecord::Migration[5.1]
  def up
    create_table :action_types do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.integer :seconds_lag, default: 0, null: false
      t.timestamps null: false
    end
    add_index :action_types, [:product_id], name: "idx_action_types_product"
    add_index :action_types, [:product_id, :internal_name], name: "unq_action_types_product_internal_name", unique: true
    add_index :action_types, [:product_id, :name], name: "unq_action_types_product_name", unique: true
    add_column :action_types, :active, :boolean, default: true, null: false
    remove_column :action_types, :product_id

    add_index :action_types, ["internal_name"], unique: true, name: "unq_action_types_internal_name"
    add_index :action_types, ["name"], unique: true, name: "unq_action_types_name"
  end

  def down
    drop_table :action_types
  end
end
