class CreateQuizPages < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_pages do |t|
      t.integer :certcourse_page_id
      t.boolean :is_optional, default: false
      t.string :quiz_text, default: "", null: false
      t.integer :wrong_answer_page_id

      t.timestamps
    end
    add_index :quiz_pages, %i[ certcourse_page_id ], name: "idx_quiz_pages_certcourse_page"
    add_foreign_key :quiz_pages, :certcourse_pages, name: "fk_quiz_pages_certcourse_page"
  end
end
