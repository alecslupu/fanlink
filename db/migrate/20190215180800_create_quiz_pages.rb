class CreateQuizPages < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_pages do |t|
      t.references :certcourse_page, foreign_key: true
      t.boolean :is_optional, default: false
      t.string :quiz_text, default: "", null: false
      t.string :color_hex, default: "#000000", null: false
      t.integer :wrong_answer_page_id, default: 0, null: false

      t.timestamps
    end
    add_index :quiz_pages, %i[ certcourse_page ], name: "idx_quiz_page_certcourse_page"
  end
end
