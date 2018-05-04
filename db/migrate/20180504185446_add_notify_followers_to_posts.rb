class AddNotifyFollowersToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :notify_followers, :boolean, default: false, null: false
  end
end
