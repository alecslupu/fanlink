class AddProductIdToRoles < ActiveRecord::Migration[5.1]
  def up
    add_reference :roles, :product, foreign_key: true
  end

  def down
    remove_reference :roles, :product
  end
end
