class CreatePortalNotifications < ActiveRecord::Migration[5.1]
  def up
    create_table :portal_notifications do |t|
      t.integer :person_id, null: false
      t.integer :product_id, null: false
      t.jsonb :body, default: {}, null: false
      t.datetime :send_me_at, null: false
      t.integer :sent_status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :portal_notifications, [:product_id], name: "idx_portal_notifications_products"
    add_index :portal_notifications, [:send_me_at], name: "idx_portal_notifications_send_me_at"
    add_index :portal_notifications, [:sent_status], name: "idx_portal_notifications_sent_status"
    add_foreign_key :portal_notifications, :people, name: "fk_portal_notifications_people", on_delete: :restrict
    add_foreign_key :portal_notifications, :products, name: "fk_portal_notifications_products", on_delete: :cascade
    remove_column :portal_notifications, :person_id

  end

  def down
    drop_table :portal_notifications
  end
end
