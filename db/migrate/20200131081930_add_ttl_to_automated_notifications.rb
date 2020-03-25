class AddTtlToAutomatedNotifications < ActiveRecord::Migration[5.1]
  def up
    add_column :automated_notifications, :ttl_hours, :integer, default: 672, null: false
  end

  def down
    remove_column :automated_notifications, :ttl_hours
  end
end
