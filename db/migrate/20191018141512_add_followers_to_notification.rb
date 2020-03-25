class AddFollowersToNotification < ActiveRecord::Migration[5.1]
  def up
    unless column_exists? :notifications, :for_followers
      add_column :notifications, :for_followers, :boolean, null: false, default: false
    end
  end
  def down
    remove_column :notifications, :for_followers
  end
end
