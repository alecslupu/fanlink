class AddAdminToPortalAccess < ActiveRecord::Migration[5.1]
  def change
    add_column :portal_accesses, :admin, :integer
  end
end
