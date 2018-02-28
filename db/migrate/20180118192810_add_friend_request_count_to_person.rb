class AddFriendRequestCountToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :friend_request_count, :integer, default: 0, null: false
  end
end
