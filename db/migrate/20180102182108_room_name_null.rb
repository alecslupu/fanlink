class RoomNameNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :rooms, :name, true
    change_column_null :rooms, :name_canonical, true
  end
end
