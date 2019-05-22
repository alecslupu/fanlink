class CreateTriviaAvailableQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_available_questions do |t|
      t.string :title
      t.integer :cooldown_period
      t.integer :time_limit
      t.integer :status
      t.string :type
      t.integer :topic_id
      t.integer :complexity

      t.timestamps
    end
    add_foreign_key :trivia_available_questions, :trivia_topics, column: :topic_id
  end
end
