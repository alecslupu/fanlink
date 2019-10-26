class AddProductIdToNotifications < ActiveRecord::Migration[5.1]
  def up
    unless column_exists? :notifications, :product_id
      add_column :notifications, :product_id, :integer, null: false
    end
  end

  def down
    remove_column :notifications, :product_id
  end
end
