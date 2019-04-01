class CreateTriviaQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_questions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :points
      t.belongs_to :trivia_package, foreign_key: true
      t.integer :time_limit
      t.string :type

      t.timestamps
    end
  end
end
