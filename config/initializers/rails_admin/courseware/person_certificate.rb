RailsAdmin.config do |config|
  config.included_models.push("PersonCertificate")
  config.model "PersonCertificate" do
    parent "Certificate"

    list do
      fields :id, :person, :certificate, :full_name
    end

    edit do
      fields :person,
             :certificate,
             :full_name,
             :issued_date,
             :validity_duration,
             :amount_paid,
             :currency,
             :fee_waived,
             :purchased_waived_date,
             :access_duration,
             :purchased_order_id,
             :purchased_platform,
             :purchased_sku,
             :unique_id,
             :issued_certificate_image_file_name,
             :issued_certificate_image_content_type,
             :issued_certificate_image_file_size,
             :issued_certificate_image_updated_at,
             :issued_certificate_pdf_file_name,
             :issued_certificate_pdf_content_type,
             :issued_certificate_pdf_file_size,
             :issued_certificate_pdf_updated_at,
             :receipt_id
    end
    show do
      fields :id,
             :person,
             :certificate,
             :full_name,
             :issued_date,
             :validity_duration,
             :amount_paid,
             :currency,
             :fee_waived,
             :purchased_waived_date,
             :access_duration,
             :purchased_order_id,
             :purchased_platform,
             :purchased_sku,
             :unique_id,
             :issued_certificate_image,
             :issued_certificate_pdf,
             :receipt_id
    end
  end
end
