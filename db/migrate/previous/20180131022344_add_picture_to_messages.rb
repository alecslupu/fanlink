class AddPictureToMessages < ActiveRecord::Migration[5.1]
  def up
    remove_column :messages, :picture_id
    add_attachment :messages, :picture
  end

  def down
    remove_attachment :messages, :picture
    add_column :messages, :picture_id, :text
  end
end
