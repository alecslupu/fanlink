class MoveComplexityField < ActiveRecord::Migration[5.1]
  def change
    remove_column :trivia_questions, :complexity
    add_column :trivia_question_packages, :complexity, :integer, default: 1
  end
end
