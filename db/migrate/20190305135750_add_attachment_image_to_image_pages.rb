class AddAttachmentImageToImagePages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :image_pages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :image_pages, :image
  end
end
