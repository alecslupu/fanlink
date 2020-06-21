# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("PersonPollOption")
  config.model "PersonPollOption" do
    parent "Poll"
  end
end
