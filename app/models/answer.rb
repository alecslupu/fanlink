class Answer < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :quiz_page

  def is_selected(person)
    PersonQuiz.where(person_id: person.id, certcourse_page_id: self.certcourse_page.id, answer_id: self.id).present?
  end

  def question
    quiz_page.quiz_text
  end

  def certcourse_name
    quiz_page.certcourse.short_name
  end
end
