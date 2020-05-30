class ConvertDownloadFilePageToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    DownloadFilePage.where.not(picture_file_name: nil).find_each do |file|
      Migration::Assets::DownloadFilePageJob.perform_later(file.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
