class CreateTriviaGames < ActiveRecord::Migration[5.1]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
    create_table :trivia_games do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.text :description
      t.integer :package_count
      t.string :long_name, null: false
      t.string :short_name, null: false
      t.text :description, default: "", null: false
      t.belongs_to :room, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.uuid :uuid, default: "gen_random_uuid()"
      t.integer :status, default: 0, null: false
      t.integer :leaderboard_size, default: 100

      t.timestamps
    end

  end
end
