class AddDeepLinkToMarketingNotification < ActiveRecord::Migration[5.1]
  def up
    add_column :marketing_notifications, :deep_link, :string, default: "", null: false
  end
  def down
    remove_column :marketing_notifications, :deep_link
  end
end
