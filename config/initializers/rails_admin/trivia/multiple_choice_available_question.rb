RailsAdmin.config do |config|
  config.included_models.push("Trivia::MultipleChoiceAvailableQuestion")
  config.model "Trivia::MultipleChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Multiple choice"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
