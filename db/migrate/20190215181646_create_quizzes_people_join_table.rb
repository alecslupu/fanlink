class CreateQuizzesPeopleJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :quizzes, :people do |t|
  	  t.integer :answer_id
  	  t.string :fill_in_response
      t.index [:quizzes_id, :people_id]
      t.index [:people_id, :quizzes_id]

      t.timestamps
    end
  end
end
