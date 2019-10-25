class AddFollowersToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :for_followers, :boolean, null: false, default: false
  end
end
