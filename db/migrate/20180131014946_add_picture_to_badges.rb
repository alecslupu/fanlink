class AddPictureToBadges < ActiveRecord::Migration[5.1]
  def up
    remove_column :badges, :picture_id
    add_attachment :badges, :picture
  end

  def down
    remove_attachment :badges, :picture
    add_column :badges, :picture_id, :text
  end
end
