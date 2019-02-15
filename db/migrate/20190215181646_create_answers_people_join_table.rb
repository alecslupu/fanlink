class CreateAnswersPeopleJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :answers, :people do |t|
      t.index [:answers_id, :people_id]
      t.index [:people_id, :answers_id]

      t.timestamps
    end
  end
end
