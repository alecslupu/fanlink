class CreateTriviaTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_topics do |t|
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
