class AddNullFalseToRoomSubscribersColumn < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:room_subscribers, :room_id, false)
    change_column_null(:room_subscribers, :person_id, false)
    change_column_null(:room_subscribers, :last_notification_time, false)
  end
end
