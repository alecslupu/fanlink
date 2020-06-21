# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Trivia::GameLeaderboard")
  config.model "Trivia::GameLeaderboard" do
    parent "Trivia::Game"
    label_plural "Game Leaderboards"
  end
end
