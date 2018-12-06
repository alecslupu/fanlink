class AddAvailableToMerchandise < ActiveRecord::Migration[5.1]
  def change
    add_column :merchandise, :available, :boolean, default: true, null: false
  end
end
