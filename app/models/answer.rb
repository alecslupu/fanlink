# == Schema Information
#
# Table name: answers
#
#  id           :bigint(8)        not null, primary key
#  quiz_page_id :integer
#  description  :string           default(""), not null
#  is_correct   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :integer          not null
#

class Answer < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :quiz_page
  has_many :user_answers, class_name: "PersonQuiz", dependent: :destroy

  validates :description, presence: true
  validate :answer_checks


  def is_selected(person)
    (is_correct || quiz_page.is_optional?) && user_answers.where(quiz_page_id: self.quiz_page_id, person_id: person.id).present?
  end

  def question
    quiz_page.quiz_text
  end

  def certcourse_name
    quiz_page.certcourse_page.certcourse.short_name
  end

  def to_s
    description
  end
  alias :title :to_s

  protected

  def answer_checks
    corect_answers = quiz_page.answers.reject{|x| !x.is_correct}.size
    errors.add(:base, _("You need at least one correct answer")) if corect_answers.zero?
    # # FLAPI-876 [RailsAdmin] add validation for optional quizzes not to have more than one correct answer
    # # FLAPI-875 [RailsAdmin] o add validation for mandatory quizzes to not be able to have more than one correct answer
    # if answers.where(is_correct: true).size > 1
    #   # FLAPI-876
    # end
  end
end
