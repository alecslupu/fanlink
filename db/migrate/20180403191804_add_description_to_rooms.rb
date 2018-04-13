class AddDescriptionToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :description, :jsonb, default: {}, null: false
  end
end
