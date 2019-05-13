module Person::Trivia
  extend ActiveSupport::Concern

  included do
    has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"
    has_many :trivia_package_leaderboards, class_name: "Trivia::RoundLeaderboard"
    has_many :trivia_question_leaderboards, class_name: "Trivia::QuestionLeaderboard"
    has_many :trivia_answers, class_name: "Trivia::Answer"
    has_many :trivia_participantions, class_name: "Trivia::Participant"
    has_many :trivia_subscribers, class_name: "Trivia::Subscriber"
  end
end
