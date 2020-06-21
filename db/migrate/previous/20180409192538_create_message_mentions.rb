class CreateMessageMentions < ActiveRecord::Migration[5.1]
  def up
    create_table :message_mentions do |t|
      t.integer :message_id, null: false
      t.integer :person_id, null: false
      t.text :linked_text, null: false
    end
    add_index :message_mentions, [:message_id], name: "ind_message_mentions_people"
    add_foreign_key :message_mentions, :messages, name: "fk_message_mentions_messages", on_delete: :cascade
    add_foreign_key :message_mentions, :people, name: "fk_message_mentions_people", on_delete: :cascade
    remove_column :message_mentions, :linked_text
    add_column :message_mentions, :location, :integer, default: 0, null: false
    add_column :message_mentions, :length, :integer, default: 0, null: false
  end

  def down
    drop_table :message_mentions
  end
end
