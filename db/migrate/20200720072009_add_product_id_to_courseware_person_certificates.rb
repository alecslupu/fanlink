class AddProductIdToCoursewarePersonCertificates < ActiveRecord::Migration[6.0]
  class PersonCertificate < ApplicationRecord
    self.table_name = :courseware_person_certificates
    belongs_to :certificate, class_name: "Fanlink::Courseware::Certificate"
  end

  def up
    add_column :courseware_person_certificates, :product_id, :integer
    add_foreign_key :courseware_person_certificates, :products, column: :product_id

    PersonCertificate.find_each do |pc|
      PersonCertificate.where(id: pc.id).update_all(product_id: pc.certificate.product_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
