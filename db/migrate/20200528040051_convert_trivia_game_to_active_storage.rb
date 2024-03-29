class ConvertTriviaGameToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    Trivia::Game.where.not(picture_file_name: nil).find_each do |level|
      Migration::Assets::Trivia::GameJob.perform_later(level.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
