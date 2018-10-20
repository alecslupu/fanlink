class CreateJoinTablePostPoll < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :polls do |t|
      t.index [:post_id, :poll_id]
      t.index [:poll_id, :post_id]
    end
  end
end
