class CreateQuizPages < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_pages do |t|
      t.references :certcourse_page, foreign_key: true
      t.boolean :is_optional, default: false
      t.string :quiz_text, default: "", null: false
      t.string :color_text
      t.integer :wrong_answer_page_id, default: 0, null: false

      t.timestamps
    end
  end
end
