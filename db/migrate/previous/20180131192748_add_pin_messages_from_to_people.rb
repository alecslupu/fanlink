class AddPinMessagesFromToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :pin_messages_from, :boolean, default: false, null: false
  end
end
