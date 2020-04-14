class AddMarketingNotificationsToPortalAccesses < ActiveRecord::Migration[5.2]

  def up
    add_column :portal_accesses, :automated_notification, :integer, default: 0, null: false
    add_column :portal_accesses, :marketing_notification, :integer, default: 0, null: false
  end

  def down
    remove_column :portal_accesses, :automated_notification
    remove_column :portal_accesses, :marketing_notification
  end
end
