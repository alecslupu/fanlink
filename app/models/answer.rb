class Answer < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :quiz_page
  has_many :user_answers, class_name: "PersonQuiz", dependent: :destroy

  def is_selected(person)
    (is_correct || quiz_page.is_optional?) && user_answers.where(quiz_page_id: self.quiz_page_id, person_id: person.id).present?
  end

  def question
    quiz_page.quiz_text
  end

  def certcourse_name
    quiz_page.certcourse_page.certcourse.short_name
  end
end
