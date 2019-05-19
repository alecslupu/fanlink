class RemoveTriviaParticipants < ActiveRecord::Migration[5.1]
  def up
    drop_table :trivia_participants
  end
end
