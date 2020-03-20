class AddDateAndTimeZoneToMarketingNotification < ActiveRecord::Migration[5.1]
  def up
    add_column :marketing_notifications, :date, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :marketing_notifications, :timezone, :integer, null: false, default: 0
  end

  def down
    remove_column :marketing_notifications, :date
    remove_column :marketing_notifications, :timezone
  end
end
