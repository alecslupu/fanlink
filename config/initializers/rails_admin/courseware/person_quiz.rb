# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("PersonQuiz")
  config.model "PersonQuiz" do
    parent "Certificate"
  end
end
