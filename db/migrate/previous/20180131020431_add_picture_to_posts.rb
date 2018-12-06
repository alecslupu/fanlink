class AddPictureToPosts < ActiveRecord::Migration[5.1]
  def up
    remove_column :posts, :picture_id
    add_attachment :posts, :picture
  end

  def down
    remove_attachment :posts, :picture
    add_column :posts, :picture_id, :text
  end
end
