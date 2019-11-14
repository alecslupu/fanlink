RailsAdmin.config do |config|
  config.included_models.push("Trivia::BooleanChoiceAvailableQuestion")
  config.model "Trivia::BooleanChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "True or False"
    edit do
      exclude_fields :type
    end
  end
end
