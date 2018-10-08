class CreateJoinTablePersonPostPollOption < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :persons, :post_poll_options do |t|
      t.integer :person_id
      t.integer :post_poll_option_id
    end
  end
end
