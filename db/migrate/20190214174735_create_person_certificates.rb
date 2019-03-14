class CreatePersonCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :person_certificates do |t|
      t.integer :person_id, null: false
      t.integer :certificate_id, null: false
      t.string :full_name, default: "", null: false
      t.datetime :issued_date
      t.integer :validity_duration, default: 0, null: false
      t.integer :amount_paid, default: 0, null: false
      t.string :currency, default: "", null: false
      t.boolean :fee_waived, default: false
      t.datetime :purchased_waived_date
      t.integer :access_duration, default: 0, null: false
      t.string :purchased_order_id
      t.integer :purchased_platform, default: 0, null: false
      t.string :purchased_sku
      t.string :issued_certificate_image_url
      t.string :issued_certificate_pdf_url
      t.string :unique_id

      t.timestamps
    end
    add_index :person_certificates, %i[ person_id ], name: "idx_person_certificates_person"
    add_foreign_key :person_certificates, :people, name: "fk_person_certificates_person"
    add_index :person_certificates, %i[ certificate_id ], name: "idx_person_certificates_certificate"
    add_foreign_key :person_certificates, :certificates, name: "fk_person_certificates_certificate"
  end
end
