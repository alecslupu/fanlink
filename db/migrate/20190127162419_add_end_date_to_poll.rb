class AddEndDateToPoll < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :end_date, :datetime, default: Time.now, null: :false
  end
end
