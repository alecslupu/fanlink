class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :quiz_page, foreign_key: true
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
