class CreateJoinTablePersonPostPollOption < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :persons_post_polls_options do |t|
      t.integer :person_id
      t.integer :post_poll_option_id
      t.integer :vote
    end
  end
end
