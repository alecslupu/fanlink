RailsAdmin.config do |config|
  config.included_models.push("PersonCertificate")
  config.model "PersonCertificate" do
    parent "Certificate"
  end
end
