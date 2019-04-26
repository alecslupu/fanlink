RailsAdmin.config do |config|
  config.included_models.push("ImagePage")
  config.model "ImagePage" do
    parent "Certificate"
  end
end
