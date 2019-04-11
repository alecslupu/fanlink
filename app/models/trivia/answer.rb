module Trivia
  class Answer < ApplicationRecord
    belongs_to :person, class_name: "Person"
    belongs_to :trivia_question, class_name: "Trivia::Question"
  end
end
