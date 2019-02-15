class CreateCertificatesCertcoursesJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :certificates, :certcourses do |t|
  	  t.integer :order, null: false
      t.index [:certificate_id, :certcourse_id]
      t.index [:certcourse_id, :certificate_id]

      t.timestamps
    end
  end
end
