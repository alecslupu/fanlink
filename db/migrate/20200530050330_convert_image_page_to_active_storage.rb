class ConvertImagePageToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    ImagePage.where.not(image_file_name: nil).find_each do |file|
      Migration::Assets::ImagePageJob.perform_later(file.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
