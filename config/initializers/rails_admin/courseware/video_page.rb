RailsAdmin.config do |config|
  config.included_models.push("VideoPage")
  config.model "VideoPage" do
    parent "Certificate"
  end
end
