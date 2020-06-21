# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Trivia::Prize")
  config.model "Trivia::Prize" do
    parent "Trivia::Game"
    label_plural "Prizes"

    edit do
      exclude_fields :game, :product
    end
    nested do
      exclude_fields :game, :product
    end
  end
end
