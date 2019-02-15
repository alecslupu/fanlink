class CreateCertificatesPeopleJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :certificates, :people do |t|
      t.string :full_name, default: ""
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
      t.index [:certificate_id, :people_id]
      t.index [:people_id, :certificate_id]

      t.timestamps
    end
  end
end
