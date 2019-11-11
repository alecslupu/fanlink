RailsAdmin.config do |config|
  config.included_models.push("Trivia::PictureAvailableQuestion")
  config.model "Trivia::PictureAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Picture choice"
    edit do
      exclude_fields :type
    end
  end
end
