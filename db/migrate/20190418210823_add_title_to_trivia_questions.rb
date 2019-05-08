class AddTitleToTriviaQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_questions, :title, :text
  end
end
