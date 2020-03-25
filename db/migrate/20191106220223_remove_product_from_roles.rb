class RemoveProductFromRoles < ActiveRecord::Migration[5.1]
  def up
    remove_reference :roles, :product
  end

  def down
    add_reference :roles, :product
  end
end
