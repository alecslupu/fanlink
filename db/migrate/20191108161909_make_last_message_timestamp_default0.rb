class MakeLastMessageTimestampDefault0 < ActiveRecord::Migration[5.1]
  def up
    change_column :rooms, :last_message_timestamp, :bigint, default: 0
  end

  def down
    change_column :rooms, :last_message_timestamp, :bigint, default: nil
  end
end
