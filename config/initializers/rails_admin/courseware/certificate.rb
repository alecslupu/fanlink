RailsAdmin.config do |config|
  config.included_models.push("Certificate")

  config.model "Certificate" do
    navigation_label "Courseware"
  end
end
