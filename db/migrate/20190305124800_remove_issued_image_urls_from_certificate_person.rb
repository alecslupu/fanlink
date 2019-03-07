class RemoveIssuedImageUrlsFromCertificatePerson < ActiveRecord::Migration[5.1]
  def up
  	remove_column :person_certificates, :issued_certificate_image_url
  	remove_column :person_certificates, :issued_certificate_pdf_url
  end

  def down
  	add_column :person_certificates, :issued_certificate_image_url, :string
  	add_column :person_certificates, :issued_certificate_pdf_url, :string
  end
end
