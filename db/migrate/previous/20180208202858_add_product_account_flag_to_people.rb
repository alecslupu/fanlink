class AddProductAccountFlagToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :product_account, :boolean, default: false, null: false
  end
end
