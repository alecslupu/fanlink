RailsAdmin.config do |config|
  config.included_models.push("Trivia::BooleanChoiceAvailableQuestion")
  config.model "Trivia::BooleanChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "True or False"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
