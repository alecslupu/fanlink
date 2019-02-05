class AddFeaturesToProduct < ActiveRecord::Migration[5.1]
  def change
    add_colum :products, :features, :interger, null: false, default: 0
  end
end
