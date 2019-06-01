class ChangePhotoOnTriviaPrizes < ActiveRecord::Migration[5.1]
  def up
    change_column :trivia_prizes, :photo_file_size, 'integer USING CAST(photo_file_size AS integer)'
  end
  def down
    change_column :trivia_prizes, :photo_file_size, 'string USING CAST(photo_file_size AS string)'
  end
end
