# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("PollOption")
  config.model "PollOption" do
    parent "Poll"

    edit do
      field :poll
      field :description, :translated
    end

    nested do
      exclude_fields :person_poll_options, :poll, :people
    end
  end
end
