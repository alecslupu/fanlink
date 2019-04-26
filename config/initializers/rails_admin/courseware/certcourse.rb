RailsAdmin.config do |config|
  config.included_models.push("Certcourse")

  config.model "Certcourse" do
    parent "Certificate"
  end
end
