class AddTtlDeepLinkAndActionToMarketingNotification < ActiveRecord::Migration[5.1]
  def up
    add_column :marketing_notifications, :ttl_hours, :integer, default: 670, null: false
    add_column :marketing_notifications, :deep_link_action, :integer, default: 0, null: false
    add_column :marketing_notifications, :deep_link_value, :string
  end

  def down
    remove_column :marketing_notifications, :ttl_hours
    remove_column :marketing_notifications, :deep_link_action
    remove_column :marketing_notifications, :deep_link_value
  end
end
