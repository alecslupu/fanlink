class AddAuthorizedToPeople < ActiveRecord::Migration[5.1]
  def up
    add_column :people, :authorized, :boolean, default: true, null: false
  end

  def down
    remove_column :people, :authorized
  end
end
