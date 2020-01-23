class AddPersonFilterToMarketingNotifications < ActiveRecord::Migration[5.1]
  def up
    add_column :marketing_notifications, :person_filter, :integer, null: false
  end

  def down
    remove_column :marketing_notifications, :person_filter
  end
end
