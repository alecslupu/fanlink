class Trivia::QuestionLeaderboard < ApplicationRecord
  belongs_to :question, class_name: "Trivia::Question", foreign_key: :trivia_question_id
  belongs_to :person, class_name: "Person"
end
