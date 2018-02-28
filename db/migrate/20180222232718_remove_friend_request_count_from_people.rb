class RemoveFriendRequestCountFromPeople < ActiveRecord::Migration[5.1]
  def up
    remove_column :people, :friend_request_count
  end
  def down
    add_column :people, :friend_request_count, :integer, default: 0, null: false
  end
end
