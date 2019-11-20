class CreateTriviaPictureAvailableAnswers < ActiveRecord::Migration[5.1]
  def change

    create_table :trivia_picture_available_answers, force: :cascade do |t|
      t.references :question
      t.boolean :is_correct, default: false, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
    add_foreign_key :trivia_picture_available_answers, :trivia_available_questions, column: :question_id
    add_attachment :trivia_picture_available_answers, :picture
  end
end
