class RemoveRoundOrderFromTriviaRounds < ActiveRecord::Migration[5.1]
  def up
    remove_column :trivia_rounds, :round_order
  end
  def down
    add_column :trivia_rounds, :round_order, :integer
  end
end
