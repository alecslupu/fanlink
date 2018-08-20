class AddInterestPermissions < ActiveRecord::Migration[5.1]
  def change
    add_column :portal_accesses, :interest, :integer, :default => 0, null: false
  end
end
