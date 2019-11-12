class AddUserToRoles < ActiveRecord::Migration[5.1]
  def up
    unless column_exists? :roles, :user
      add_column :roles, :user, :integer, default: 0, null: false
    end
  end

  def down
    remove_column :roles, :user
  end
end
