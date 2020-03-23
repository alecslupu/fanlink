class AddMarketingAndAutomatedNotificationToRoles < ActiveRecord::Migration[5.1]
  def up
    add_column :roles, :automated_notification, :integer, default: 0, null: false
    add_column :roles, :marketing_notification, :integer, default: 0, null: false
  end

  def down
    remove_column :roles, :automated_notification
    remove_column :roles, :marketing_notification
  end
end
