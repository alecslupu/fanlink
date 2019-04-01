class CreateTriviaGames < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_games do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.text :description
      t.integer :package_count

      t.timestamps
    end
  end
end
