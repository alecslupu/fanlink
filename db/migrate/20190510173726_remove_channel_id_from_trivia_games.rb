class RemoveChannelIdFromTriviaGames < ActiveRecord::Migration[5.1]
  def up
    remove_column :trivia_games, :uuid
    remove_column :trivia_rounds, :uuid
  end
  def down
    add_column :trivia_games, :uuid, :uuid, default: "gen_random_uuid()"
    add_column :trivia_rounds, :uuid, :uuid, default: "gen_random_uuid()"
  end
end
