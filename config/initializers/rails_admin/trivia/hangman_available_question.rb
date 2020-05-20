# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::HangmanAvailableQuestion")
  config.model "Trivia::HangmanAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Fill in the blank"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
