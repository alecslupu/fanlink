class RemoveDeepLinkValueAndActionFromMarketingNotifications < ActiveRecord::Migration[5.1]
  def up
    remove_column :marketing_notifications, :deep_link_value
    remove_column :marketing_notifications, :deep_link_action
  end

  def down
    add_column :marketing_notifications, :deep_link_value, :string
    add_column :marketing_notifications, :deep_link_action, :integer
  end
end
