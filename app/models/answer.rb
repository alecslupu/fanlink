class Answer < ApplicationRecord
  belongs_to :quiz_page

  def is_selected(person)
  	PersonQuiz.find_by(person_id: person.id, quiz_page_id: self.quiz_page.id, answer_id: self.id).present?
  end
end
