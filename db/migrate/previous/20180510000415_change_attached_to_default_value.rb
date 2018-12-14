class ChangeAttachedToDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column :product_beacons, :attached_to, :integer, :default => nil
  end
end
