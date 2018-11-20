class AddOrderToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :order, :integer, default: 0, null: false
  end
end
