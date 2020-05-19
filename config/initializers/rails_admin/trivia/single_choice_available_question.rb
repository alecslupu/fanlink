# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::SingleChoiceAvailableQuestion")
  config.model "Trivia::SingleChoiceAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Single choice"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
