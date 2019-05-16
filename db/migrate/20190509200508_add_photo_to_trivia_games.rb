class AddPhotoToTriviaGames < ActiveRecord::Migration[5.1]
  def up
    add_attachment :trivia_games, :picture
  end

  def down
    remove_attachment :trivia_games, :picture
  end
end
