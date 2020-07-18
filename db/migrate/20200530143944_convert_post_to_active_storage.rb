class ConvertPostToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Post.where.not(picture_file_name: nil).find_each do |message|
      Migration::Assets::PostJob.perform_later(message.id, "picture")
    end
    Post.where.not(audio_file_name: nil).find_each do |message|
      Migration::Assets::PostJob.perform_later(message.id, "audio")
    end
    Post.where.not(video_file_name: nil).find_each do |message|
      Migration::Assets::PostJob.perform_later(message.id, "video")
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
