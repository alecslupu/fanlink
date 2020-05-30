class ConvertVideoPageToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    VideoPage.where.not(video_file_name: nil).find_each do |message|
      Migration::Assets::VideoPageJob.perform_later(message.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
