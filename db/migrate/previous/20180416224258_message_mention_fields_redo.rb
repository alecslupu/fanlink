class MessageMentionFieldsRedo < ActiveRecord::Migration[5.1]
  def up
    remove_column :message_mentions, :linked_text
    add_column :message_mentions, :location, :integer, default: 0, null: false
    add_column :message_mentions, :length, :integer, default: 0, null: false
  end
  def down
    add_column :message_mentions, :linked_text, :text, default: "", null: false
  end
end
