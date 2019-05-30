class RenameForeignKey < ActiveRecord::Migration[5.1]
  def up
    remove_foreign_key :trivia_answers, :trivia_questions
    add_foreign_key :trivia_answers, :trivia_questions, name: :trivia_answers_questions_id_fkey
    remove_foreign_key :trivia_answers, :people
    add_foreign_key :trivia_answers, :people, name: :trivia_answers_person_id_fkey
  end
  def down
    remove_foreign_key :trivia_answers, :people
    add_foreign_key :trivia_answers, :people
    remove_foreign_key :trivia_answers, :trivia_questions
    add_foreign_key :trivia_answers, :trivia_questions
  end
end
