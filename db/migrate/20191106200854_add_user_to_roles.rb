class AddUserToRoles < ActiveRecord::Migration[5.1]
  def up
    add_column :roles, :user, :integer, default: 0, null: false

  end

  def down
    remove_column :roles, :user
  end
end
