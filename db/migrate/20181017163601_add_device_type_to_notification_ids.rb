class AddDeviceTypeToNotificationIds < ActiveRecord::Migration[5.1]
  def change
    add_column :notification_device_ids, :device_type, :integer, default: 0, null: false
  end
end
