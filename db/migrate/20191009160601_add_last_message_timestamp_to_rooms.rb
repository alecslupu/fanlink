class AddLastMessageTimestampToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :last_message_timestamp, :bigint
  end
end
