class AddPointValueToBadges < ActiveRecord::Migration[5.1]
  def change
    add_column :badges, :point_value, :integer, default: 0, null: false
  end
end
