# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
  #   navigation_label "Trivia"
    label_plural "Trivia Games"

    list do
      fields :id, :description, :round_count, :long_name, :status
      field :start_date, :unix_timestamp
    end

    edit do
      fields :short_name, :long_name, :description, :room, :leaderboard_size, :picture
      field :status, :enum do
        # read_only { bindings[:object].persisted? }
      end
      field :start_date, :unix_timestamp do
        read_only { true }
      end
      field :prizes do
        visible { bindings[:object].persisted? }
      end
      field :rounds do
        visible { bindings[:object].persisted? }
      end
    end
    show do
      fields :short_name, :long_name, :description, :room, :status, :leaderboard_size, :picture
      field :start_date, :unix_timestamp
      fields :prizes, :rounds
    end
  end

end
