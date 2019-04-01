class AddProductToTriviaGames < ActiveRecord::Migration[5.1]
  def change
    add_reference :trivia_games, :product, foreign_key: true
  end
end
