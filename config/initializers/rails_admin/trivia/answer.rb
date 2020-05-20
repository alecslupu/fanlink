# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::Answer")
  config.model "Trivia::Answer" do
    parent "Trivia::Game"
    navigation_label "Answer"

    edit do
      exclude_fields :product
    end

  end
end
