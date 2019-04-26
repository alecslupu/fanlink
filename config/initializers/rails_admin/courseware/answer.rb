RailsAdmin.config do |config|
  config.included_models.push("Answer")

  config.model "Answer" do
    parent "Certificate"
  end
end
