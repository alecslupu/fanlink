class AddAttachmentVideoToVideoPages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :video_pages do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :video_pages, :video
  end
end
