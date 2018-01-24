class AddAttachmentPictureToPeople < ActiveRecord::Migration[5.1]
  def self.up
    remove_column :people, :picture_id
    change_table :people do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :people, :picture
    add_column :people, :picture_id, :text
  end
end
