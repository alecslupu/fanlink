class AddPortalNotificationsPermission < ActiveRecord::Migration[5.1]
  def up
    add_column :portal_accesses, :portal_notification, :integer, default: 0, null: false
    add_column :roles, :portal_notification, :integer, default: 0, null: false
  end
  def down
    remove_column :portal_accesses, :portal_notification
    remove_column :roles, :portal_notification
  end
end
