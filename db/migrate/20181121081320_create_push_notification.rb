class CreatePushNotification < ActiveRecord::Migration[5.1]
  def change
    create_table :push_notifications do |t|
      t.integer :product_id, null: false
      t.jsonb :body, default: {}, null: false
      t.timestamps null: false
    end

    add_index :push_notifications, [:product_id], name: "idx_push_notifications_products"
    add_foreign_key :push_notifications, :products, name: "fk_push_notifications_products", on_delete: :cascade
  end
end
