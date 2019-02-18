class CreatePersonCertcourses < ActiveRecord::Migration[5.1]
  def change
  	create_table :person_certcourses do |t|
  	  t.integer :person_id, null: false
      t.integer :certcourse_id, null: false
  	  t.integer :last_completed_page_id, default: 0, null: false
  	  t.boolean :is_completed, default: false

      t.timestamps
    end
    add_index :person_certcourses, %i[ person_id ], name: "idx_person_certcourses_person"
    add_foreign_key :person_certcourses, :people, name: "fk_person_certcourses_person"
    add_index :person_certcourses, %i[ certcourse_id ], name: "idx_person_certcourses_certcourse"
    add_foreign_key :person_certcourses, :certcourses, name: "fk_person_certcourses_certcourse"
  end
end
