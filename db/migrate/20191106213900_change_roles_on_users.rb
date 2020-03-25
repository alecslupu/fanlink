class ChangeRolesOnUsers < ActiveRecord::Migration[5.1]
  def up
    rename_column :people, :role, :old_role
    add_reference :people, :role, index: true, foreign_key: true
  end

  def down
    remove_reference :people, :role
    rename_column :people, :old_role, :role
  end
end
