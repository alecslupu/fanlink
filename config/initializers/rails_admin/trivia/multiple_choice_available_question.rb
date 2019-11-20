RailsAdmin.config do |config|
  config.included_models.push("Trivia::MultipleChoiceAvailableQuestion")
  config.model "Trivia::MultipleChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Multiple choice"
    edit do
      exclude_fields :type
    end
  end
end
