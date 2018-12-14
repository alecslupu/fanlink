class AddActiveFlagToActionType < ActiveRecord::Migration[5.1]
  def change
    add_column :action_types, :active, :boolean, default: true, null: false
  end
end
