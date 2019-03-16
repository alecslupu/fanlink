class AddReceiptIdToPersonCertificates < ActiveRecord::Migration[5.1]
  def change
  	add_column :person_certificates, :receipt_id, :string
  end
end
