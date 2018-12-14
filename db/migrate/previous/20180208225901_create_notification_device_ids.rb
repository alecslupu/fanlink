class CreateNotificationDeviceIds < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_device_ids do |t|
      t.integer :person_id, null: false
      t.text :device_identifier, null: false
      t.timestamps null: false
    end
    add_index :notification_device_ids, %i[ person_id ], name: "idx_notification_device_ids_person"
    add_index :notification_device_ids, %i[ device_identifier ], unique: true, name: "unq_notification_device_ids_device"
    add_foreign_key :notification_device_ids, :people, name: "fk_notification_device_ids_people", on_delete: :cascade
  end
end
