RailsAdmin.config do |config|
  config.included_models.push("Trivia::SingleChoiceAvailableQuestion")
  config.model "Trivia::SingleChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Single choice"
    edit do
      exclude_fields :type
    end
  end
end
