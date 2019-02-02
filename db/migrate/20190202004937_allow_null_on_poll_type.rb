class AllowNullOnPollType < ActiveRecord::Migration[5.1]
  def change
    change_column_null :polls, :poll_type, true
    change_column_null :polls, :poll_type_id, true
  end
end
