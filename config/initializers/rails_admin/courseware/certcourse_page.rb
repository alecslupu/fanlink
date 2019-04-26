RailsAdmin.config do |config|
  config.included_models.push("CertcoursePage")

  config.model "CertcoursePage" do
    parent "Certificate"
  end
end
