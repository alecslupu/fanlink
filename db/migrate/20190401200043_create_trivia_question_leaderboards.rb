class CreateTriviaQuestionLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_question_leaderboards do |t|
      t.belongs_to :trivia_question, foreign_key: true
      t.integer :nb_points
      t.belongs_to :person, foreign_key: true

      t.timestamps
    end
  end
end
