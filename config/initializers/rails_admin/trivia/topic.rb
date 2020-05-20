# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::Topic")
  config.model "Trivia::Topic" do
    parent "Trivia::Game"
    label_plural "Topics"

    edit do
      exclude_fields :product
    end
    nested do
      exclude_fields :product
    end
  end
end
