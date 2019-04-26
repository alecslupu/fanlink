RailsAdmin.config do |config|
  config.included_models.push("PersonCertcourse")
  config.model "PersonCertcourse" do
    parent "Certificate"
  end
end
