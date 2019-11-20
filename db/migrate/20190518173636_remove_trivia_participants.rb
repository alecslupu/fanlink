class RemoveTriviaParticipants < ActiveRecord::Migration[5.1]
  def up
    if table_exists?(:trivia_participants)
      drop_table :trivia_participants
    end
  end
end
