class AddChatBannedToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :chat_banned, :boolean, default: false, null: false
  end
end
