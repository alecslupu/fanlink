RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
    configure :compute_gameplay do

    end

    navigation_label "Trivia"
    edit do
      fields :short_name, :long_name, :description, :room, :leaderboard_size, :picture
      field :status, :enum do
        read_only { bindings[:object].persisted? }
      end
      field :start_date, :unix_timestamp
      field :prizes do
        visible { bindings[:object].persisted? }
      end
      field :rounds do
        visible { bindings[:object].persisted? }
      end

      field :compute_gameplay, :boolean do
        read_only { bindings[:object].persisted? }
      end
    end
    show do
      fields :short_name, :long_name, :description, :room, :status, :leaderboard_size, :picture
      field :start_date, :unix_timestamp
      fields :prizes, :rounds
    end
  end

  %w(
    Trivia::QuestionRound
    Trivia::GameLeaderboard
    Trivia::QuestionRoundLeaderboard
    Trivia::QuestionLeaderboard
    Trivia::RoundLeaderboard
    Trivia::Subscriber
    Trivia::AvailableQuestion
    Trivia::Answer
    Trivia::Topic
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "Trivia::Game"
    end
  end

end
