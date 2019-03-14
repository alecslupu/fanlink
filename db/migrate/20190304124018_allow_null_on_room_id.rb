class AllowNullOnRoomId < ActiveRecord::Migration[5.1]
  def change
  	change_column_null :certificates, :room_id, true
  end
end
