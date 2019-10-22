class AddAdminToPortalAccess < ActiveRecord::Migration[5.1]
  def self.up
    add_column :portal_accesses, :admin, :integer
  end
  def self.down
    remove_column :portal_accesses, :admin
  end

end
