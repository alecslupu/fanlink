class Trivia::QuestionLeaderboard < ApplicationRecord
  belongs_to :trivia_question, class_name: "Trivia::Question"
  belongs_to :person, class_name: "Person"
end
