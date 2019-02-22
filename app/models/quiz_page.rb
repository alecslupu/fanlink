class QuizPage < ApplicationRecord
  belongs_to :certcourse_page

  has_many :answers
end
