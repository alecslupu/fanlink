RailsAdmin.config do |config|
  config.included_models.push("Trivia::HangmanAvailableQuestion")
  config.model "Trivia::HangmanAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Fill in the blank"
    edit do
      exclude_fields :type
    end
  end
end
