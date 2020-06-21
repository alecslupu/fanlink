class CreateMessages < ActiveRecord::Migration[5.1]
  def up
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

    add_column :messages, :status, :integer, default: 0, null: false
    Message.update_all(status: :posted)

    remove_column :messages, :picture_id
    add_attachment :messages, :picture
    change_column_null :messages, :body, true

    change_table :messages do |t|
      t.attachment :audio
    end
  end

  def down
    drop_table :messages
  end
end
