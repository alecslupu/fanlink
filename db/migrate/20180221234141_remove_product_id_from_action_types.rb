class RemoveProductIdFromActionTypes < ActiveRecord::Migration[5.1]
  def up
    remove_column :action_types, :product_id
    add_index :action_types, [ :internal_name ], name: "unq_action_types_internal_name", unique: true
    add_index :action_types, [ :name ], name: "unq_action_types_name", unique: true
  end

  def down
    add_column :action_types, :product_id, :integer
  end
end
