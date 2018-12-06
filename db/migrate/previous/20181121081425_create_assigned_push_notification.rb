class CreateAssignedPushNotification < ActiveRecord::Migration[5.1]
  def change
    create_table :assigned_push_notifications do |t|
      t.integer :push_notification_id, null: false
      t.integer :assigned_id, null: false
      t.text :assigned_type, null: false
      t.timestamps null: false
      t.index [:push_notification_id]
    end
    add_index :assigned_push_notifications, [:assigned_id, :assigned_type], name: "idx_push_notifications_assigned"
  end
end
