RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
    navigation_label "Trivia"
    edit do
      fields :short_name, :long_name, :description, :room, :status, :leaderboard_size, :picture
      field :start_date, :unix_timestamp
      fields :prizes, :rounds
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
    Trivia::Prize

    Trivia::QuestionLeaderboard
    Trivia::RoundLeaderboard
    Trivia::Subscriber
    Trivia::Answer
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "Trivia::Game"
    end
  end

  config.included_models << "Trivia::Prize"
  config.model "Trivia::Prize" do
    parent "Trivia::Game"

    nested do
      exclude_fields :game
    end
  end
  config.included_models << "Trivia::Round"
  config.model "Trivia::Round" do
    parent "Trivia::Game"

    edit do
      fields :status, :complexity
      field :start_date, :unix_timestamp
      field :questions
    end
    nested do
      exclude_fields :game
    end
  end
  config.included_models << "Trivia::Question"
  config.model "Trivia::Question" do
    parent "Trivia::Game"

    edit do
      fields :title, :time_limit, :status, :question_order, :cooldown_period
      #  trivia_round_id :bigint(8)
      #  type            :string
      #  start_date      :integer
      #  end_date        :integer

      field :available_answers
    end
    nested do
      exclude_fields :round
    end
  end
  config.included_models << "Trivia::AvailableAnswer"
  config.model "Trivia::AvailableAnswer" do
    parent "Trivia::Game"

    # edit do
    #   fields :title, :time_limit, :status, :question_order, :cooldown_period
    #   #  trivia_round_id :bigint(8)
    #   #  type            :string
    #   #  start_date      :integer
    #   #  end_date        :integer
    #
    #   field :available_answers
    # end
    nested do
      exclude_fields :question
    end
  end
end
