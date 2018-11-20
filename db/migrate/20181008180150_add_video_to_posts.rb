class AddVideoToPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :posts do |t|
      t.attachment :video
      t.string :video_job_id
    end
  end

  def self.down
    remove_attachment :posts, :video
  end
end
