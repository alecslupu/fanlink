class Answer < ApplicationRecord
  belongs_to :quiz_page

  def is_selected(person)
    PersonQuiz.find_by(person_id: person.id, quiz_page_id: self.quiz_page.id, answer_id: self.id).present?
  end

  def question
    quiz_page.quiz_text
  end

  def certcourse_name
    quiz_page.certcourse_page.certcourse.short_name
  end
end
