class CreateTriviaPrizes < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_prizes do |t|
      t.belongs_to :trivia_game, foreign_key: true
      t.integer :status, default: 0, null: false
      t.text :description
      t.integer :position, default: 1, null: false
      t.string :photo_file_name
      t.string :photo_file_size
      t.string :photo_content_type
      t.string :photo_updated_at

      t.timestamps
    end
  end
end
