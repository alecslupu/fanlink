class AddRootToPortalAccesses < ActiveRecord::Migration[5.1]
  def up
    add_column :portal_accesses, :root, :integer, default: 0
  end

  def down
    remove_column :portal_accesses, :root
  end
end
