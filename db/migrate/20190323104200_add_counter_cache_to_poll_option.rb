class AddCounterCacheToPollOption < ActiveRecord::Migration[5.1]
  def up
    add_column :poll_options, :person_poll_options_count, :integer
    PollOption.reset_column_information
    PollOption.find_each { |a| PollOption.reset_counters(a.id, :person_poll_options) }
  end

  def down
    remove_column :poll_options, :person_poll_options_count
  end
end
