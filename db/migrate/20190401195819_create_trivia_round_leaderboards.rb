class CreateTriviaRoundLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_round_leaderboards do |t|
      t.belongs_to :trivia_round, foreign_key: true
      t.integer :nb_points
      t.integer :position
      t.belongs_to :person, foreign_key: true
      t.integer :average_time, default: 0

      t.timestamps
    end
  end
end
