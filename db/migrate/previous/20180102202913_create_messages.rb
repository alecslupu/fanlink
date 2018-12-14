class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :person_id, null: false
      t.integer :room_id, null: false
      t.text :body, null: false
      t.text :picture_id
      t.boolean :hidden, default: false, null: false
      t.timestamps null: false
    end
    add_index :messages, [:room_id], name: "idx_messages_room"
    add_foreign_key :messages, :people, name: "fk_messages_people", on_delete: :cascade
    add_foreign_key :messages, :rooms, name: "fk_messages_rooms", on_delete: :cascade
  end
end
