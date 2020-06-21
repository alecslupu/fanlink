# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Trivia::RoundLeaderboard")
  config.model "Trivia::RoundLeaderboard" do
    parent "Trivia::Game"
    label_plural "Round Leaderboards"
  end
end
