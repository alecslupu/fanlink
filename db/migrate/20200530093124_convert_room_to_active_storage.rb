class ConvertRoomToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    Room.where.not(picture_file_name: nil).find_each do |room|
      Migration::Assets::RoomJob.perform_later(room.id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
