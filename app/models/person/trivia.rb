module Person::Trivia
  extend ActiveSupport::Concern

  included do
    has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard", dependent: :destroy
    has_many :trivia_package_leaderboards, class_name: "Trivia::RoundLeaderboard", dependent: :destroy
    has_many :trivia_question_leaderboards, class_name: "Trivia::QuestionLeaderboard", dependent: :destroy
    has_many :trivia_answers, class_name: "Trivia::Answer", dependent: :destroy
    has_many :trivia_subscribers, class_name: "Trivia::Subscriber", dependent: :destroy
  end
end
