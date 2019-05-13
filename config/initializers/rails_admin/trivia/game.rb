RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
    navigation_label "Trivia"
  end

  %w(
    Trivia::QuestionPackage
    Trivia::AvailableAnswer
    Trivia::GameLeaderboard
    Trivia::QuestionPackageLeaderboard
    Trivia::Participant
    Trivia::Prize
    Trivia::Question
    Trivia::QuestionLeaderboard
    Trivia::Answer
  ).each do |model|
    config.included_models << model
    config.model model do
      parent "Trivia::Game"
    end
  end
end
