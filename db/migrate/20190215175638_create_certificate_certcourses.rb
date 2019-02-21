class CreateCertificateCertcourses < ActiveRecord::Migration[5.1]
  def change
  	create_table :certificate_certcourses do |t|
  	  t.integer :certificate_id
  	  t.integer :certcourse_id
  	  t.integer :order, null: false

      t.timestamps
    end
    add_index :certificate_certcourses, %i[ certificate_id ], name: "idx_certificate_certcourses_certificate"
    add_foreign_key :certificate_certcourses, :certificates, name: "fk_certificate_certcourses_certificate"
    add_index :certificate_certcourses, %i[ certcourse_id ], name: "idx_certificate_certcourses_certcourse"
    add_foreign_key :certificate_certcourses, :certcourses, name: "fk_certificate_certcourses_certcourse"
  end
end
