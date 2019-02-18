class CreateCertificatesCertcourses < ActiveRecord::Migration[5.1]
  def change
  	create_table :certificates_certcourses do |t|
  	  t.integer :certificate_id
  	  t.integer :certcourse_id
  	  t.integer :order, null: false

      t.timestamps
    end
    add_index :certificates_certcourses, %i[ certificate_id ], name: "idx_certificates_certcourses_certificate"
    add_foreign_key :certificates_certcourses, :certificates, name: "fk_certificates_certcourses_certificate"
    add_index :certificates_certcourses, %i[ certcourse_id ], name: "idx_certificates_certcourses_certcourse"
    add_foreign_key :certificates_certcourses, :certcourses, name: "fk_certificates_certcourses_certcourse"
  end
end
