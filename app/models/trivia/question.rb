class Trivia::Question < ApplicationRecord
  belongs_to :trivia_package, class_name: "Trivia::Package", counter_cache: :question_count
end
