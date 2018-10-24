class AddOrderToInterests < ActiveRecord::Migration[5.1]
  def change
    add_column :interests, :order, :integer, default: 0, null: false
  end
end
