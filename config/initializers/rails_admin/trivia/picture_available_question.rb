# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::PictureAvailableQuestion")
  config.model "Trivia::PictureAvailableQuestion" do
    parent "Trivia::AvailableQuestion"
    label_plural "Picture choice"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status, :available_answers
    end
  end
end
