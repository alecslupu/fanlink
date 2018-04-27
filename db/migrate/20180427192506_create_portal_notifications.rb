class CreatePortalNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :portal_notifications do |t|
      t.integer :person_id, null: false
      t.integer :product_id, null: false
      t.jsonb :body, default: {}, null: false
      t.datetime :send_me_at, null: false
      t.integer :status, default: 0, null: false
    end
    add_index :portal_notifications, [:product_id], name: "idx_portal_notifications_products"
    add_index :portal_notifications, [:send_me_at], name: "idx_portal_notifications_send_me_at"
    add_index :portal_notifications, [:status], name: "idx_portal_notifications_status"
    add_foreign_key :portal_notifications, :people, name: "fk_portal_notifications_people", on_delete: :restrict
    add_foreign_key :portal_notifications, :products, name: "fk_portal_notifications_products", on_delete: :cascade
  end
end
