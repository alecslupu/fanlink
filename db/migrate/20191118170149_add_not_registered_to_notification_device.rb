class AddNotRegisteredToNotificationDevice < ActiveRecord::Migration[5.1]
  def up
    add_column :notification_device_ids, :not_registered, :boolean, default: false, null: false
  end

  def down
    remove_column :notification_device_ids, :not_registered
  end
end
