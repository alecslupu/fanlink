class CreateTriviaQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_questions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :complexity,  default: 1
      t.belongs_to :trivia_package, foreign_key: true
      t.integer :time_limit
      t.string :type
      t.integer :question_order, default: 1, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
