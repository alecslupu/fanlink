class CreateMessageMentions < ActiveRecord::Migration[5.1]
  def change
    create_table :message_mentions do |t|
      t.integer :message_id, null: false
      t.integer :person_id, null: false
      t.text :linked_text, null: false
    end
    add_index :message_mentions, [:message_id], name: "ind_message_mentions_people"
    add_foreign_key :message_mentions, :messages, name: "fk_message_mentions_messages"
    add_foreign_key :message_mentions, :people, name: "fk_message_mentions_people"
  end
end
