class ConvertTriviaPictureAvailableAnswerToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Trivia::PictureAvailableAnswerJob.where.not(picture_file_name: nil).find_each do |level|
      Migration::Assets::Trivia::PictureAvailableAnswerJob.perform_later(level.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
