class ConvertLevelToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Level.where.not(picture_file_name: nil).find_each do |level|
      Migration::Assets::LevelJob.perform_later(level.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
