class AddFeaturesToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :features, :integer, null: false, default: 0
  end
end
