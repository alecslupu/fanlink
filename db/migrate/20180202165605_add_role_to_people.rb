class AddRoleToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :role, :integer, default: 0, null: false
  end
end
