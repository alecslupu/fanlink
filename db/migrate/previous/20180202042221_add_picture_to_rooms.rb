class AddPictureToRooms < ActiveRecord::Migration[5.1]
  def up
    remove_column :rooms, :picture_id
    add_attachment :rooms, :picture
  end
  def down
    remove_attachment :rooms, :picture
    add_column :rooms, :picture_id, :text
  end
end
