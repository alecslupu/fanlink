RailsAdmin.config do |config|
  config.included_models.push("CertificateCertcourse")
  config.model "CertificateCertcourse" do
    parent "Certificate"
  end
end
