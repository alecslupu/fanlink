class CreateCertcoursesPeopleJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :certcourses, :people do |t|
  	  t.integer :last_completed_page_id, default: 0, null: false
  	  t.boolean :is_completed, default: false
      t.index [:certcourse_id, :people_id]
      t.index [:people_id, :certcourse_id]

      t.timestamps
    end
  end
end
