class AddProductIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :product_id, :integer, null: false
  end
end
