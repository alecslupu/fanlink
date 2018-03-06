class NullRoomCreatedBy < ActiveRecord::Migration[5.1]
  def up
    change_column_null :rooms, :created_by_id, true
  end
end
