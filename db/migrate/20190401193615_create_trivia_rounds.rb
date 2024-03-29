class CreateTriviaRounds < ActiveRecord::Migration[5.1]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    create_table :trivia_rounds do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :question_count
      t.belongs_to :trivia_game, foreign_key: true
      t.integer :leaderboard_size, default: 100
      t.integer :round_order, default: 1, null: false
      t.integer :status, default: 0, null: false
      t.uuid :uuid, :uuid, default: "gen_random_uuid()"
      t.integer :complexity, default: 1
      t.timestamps
    end

  end
end
