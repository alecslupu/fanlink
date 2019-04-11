class ChangeTrivia < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_prizes, :delivered, :boolean, default: false
    add_column :trivia_prizes, :prize_type, :integer, default: 0
    add_column :trivia_answers, :is_correct, :boolean, default: false

  end
end
