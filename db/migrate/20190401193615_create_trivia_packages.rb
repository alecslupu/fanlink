class CreateTriviaPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_packages do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :question_count
      t.belongs_to :game_id, foreign_key: true

      t.timestamps
    end
  end
end
