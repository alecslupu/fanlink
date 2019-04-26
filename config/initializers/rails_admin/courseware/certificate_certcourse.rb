RailsAdmin.config do |config|
  config.included_models.push("CertificateCertcourse")
  config.model "CertificateCertcourse" do
    parent "Certificate"

    list do
      fields :certcourse, :certcourse_order
    end
    edit do
      fields :certificate, :certcourse, :certcourse_order
    end
    show do
      fields :id, :certificate, :certcourse, :certcourse_order, :created_at, :updated_at
    end
  end
end
