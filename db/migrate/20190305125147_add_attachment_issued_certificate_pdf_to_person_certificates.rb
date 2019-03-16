class AddAttachmentIssuedCertificatePdfToPersonCertificates < ActiveRecord::Migration[5.1]
  def self.up
    change_table :person_certificates do |t|
      t.attachment :issued_certificate_pdf
    end
  end

  def self.down
    remove_attachment :person_certificates, :issued_certificate_pdf
  end
end
