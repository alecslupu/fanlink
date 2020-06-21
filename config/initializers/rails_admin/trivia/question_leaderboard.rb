# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Trivia::QuestionLeaderboard")
  config.model "Trivia::QuestionLeaderboard" do
    parent "Trivia::Game"
    label_plural "Question Leaderboards"
  end
end
