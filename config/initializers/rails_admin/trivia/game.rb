RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
  #   configure :compute_gameplay do
  #
  #   end
  #
  #   navigation_label "Trivia"
  #
  end

  #
  #
  # Trivia::BooleanChoiceQuestion
  # Trivia::HangmanQuestion
  # Trivia::MultipleChoiceQuestion
  # Trivia::PictureQuestion
  # Trivia::SingleChoiceQuestion
  %w(
    Trivia::Answer
    Trivia::AvailableAnswer
    Trivia::PictureAvailableAnswer
    Trivia::GameLeaderboard
    Trivia::Prize
    Trivia::Question
    Trivia::QuestionLeaderboard
    Trivia::Round
    Trivia::RoundLeaderboard
    Trivia::Subscriber
    Trivia::Topic
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "Trivia::Game"
    end
  end
  %w(
    Trivia::AvailableQuestion
    Trivia::PictureAvailableQuestion
    Trivia::BooleanChoiceAvailableQuestion
    Trivia::HangmanAvailableQuestion
    Trivia::MultipleChoiceAvailableQuestion
    Trivia::SingleChoiceAvailableQuestion
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "Trivia::Game"
    end
  end

end
