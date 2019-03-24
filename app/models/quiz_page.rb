class QuizPage < CertcoursePage
  has_many :answers, foreign_key: :certcourse_page_id
  
  attr_accessor :wrong_answer_page_id
end
