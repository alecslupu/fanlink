class AddUniqueActionTypes < ActiveRecord::Migration[5.1]
  def change
    add_index :action_types, ["internal_name"], unique: true, name: "unq_action_types_internal_name"
    add_index :action_types, ["name"], unique: true, name: "unq_action_types_name"
  end
end
