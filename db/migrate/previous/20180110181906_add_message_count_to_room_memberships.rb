class AddMessageCountToRoomMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :room_memberships, :message_count, :integer, default: 0, null: false
  end
end
