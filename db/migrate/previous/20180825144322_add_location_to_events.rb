class AddLocationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :events, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
