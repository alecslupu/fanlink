RailsAdmin.config do |config|
  config.included_models.push("Following")
  config.model "Following" do
    label_plural "Follow Relationships"
  end
end
