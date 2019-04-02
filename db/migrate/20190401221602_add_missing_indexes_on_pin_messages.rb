class AddMissingIndexesOnPinMessages < ActiveRecord::Migration[5.1]
  def change
    add_index :pin_messages, :person_id
    add_index :pin_messages, :room_id
    add_index :pin_messages, [:person_id, :room_id]
  end
end
