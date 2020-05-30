class ConvertPersonCertificatesToActiveStorage < ActiveRecord::Migration[6.0]
  def up
    PersonCertificate.where.not(issued_certificate_image_file_name: nil).find_each do |message|
      Migration::Assets::PersonCertificateJob.perform_later(message.id, "issued_certificate_image")
    end
    PersonCertificate.where.not(issued_certificate_pdf_file_name: nil).find_each do |message|
      Migration::Assets::PersonCertificateJob.perform_later(message.id, "issued_certificate_pdf")
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
