class AddFieldsToProductBeacons < ActiveRecord::Migration[5.1]
  def change
    add_column :product_beacons, :uuid, :uuid
    add_column :product_beacons, :lower, :integer
    add_column :product_beacons, :upper, :integer
  end
end
