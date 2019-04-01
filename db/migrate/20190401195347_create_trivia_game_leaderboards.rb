class CreateTriviaGameLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_game_leaderboards do |t|
      t.belongs_to :trivia_game, foreign_key: true
      t.integer :nb_points
      t.integer :position
      t.belongs_to :person, foreign_key: true

      t.timestamps
    end
  end
end
