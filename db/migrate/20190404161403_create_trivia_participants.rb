class CreateTriviaParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_participants do |t|
      t.belongs_to :person, foreign_key: true
      t.belongs_to :trivia_game, foreign_key: true

      t.timestamps
    end
  end
end
