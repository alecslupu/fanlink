class SetUpperLowerToNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :product_beacons, :upper, false
    change_column_null :product_beacons, :lower, false
  end
end
