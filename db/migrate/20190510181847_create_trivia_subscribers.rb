class CreateTriviaSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_subscribers do |t|
      t.references :person, foreign_key: true
      t.references :trivia_game, foreign_key: true
      t.boolean :subscribed, default: false

      t.timestamps
    end
  end
end
