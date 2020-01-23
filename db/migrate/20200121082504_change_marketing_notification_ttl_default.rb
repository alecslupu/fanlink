class ChangeMarketingNotificationTtlDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :marketing_notifications, :ttl_hours, :integer, default: 672
  end

  def down
    change_column :marketing_notifications, :ttl_hours, :integer, default: 670
  end
end
