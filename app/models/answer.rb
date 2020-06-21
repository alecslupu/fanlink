# frozen_string_literal: true

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
  has_paper_trail ignore: [:created_at, :updated_at]

  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :quiz_page
  has_many :user_answers, class_name: "PersonQuiz", dependent: :destroy

  validates :description, presence: true
  validate :answer_checks

  scope :for_product, -> (product) { where(product_id: product.id) }


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
    correct_answers = quiz_page.answers.reject{|answer| !answer.is_correct}.size
    errors.add(:base, _("You need at least one correct answer. The changes have not been saved. Please refresh and try again")) if correct_answers.zero?
    # FLAPI-875 [RailsAdmin] o add validation for mandatory quizzes to not be able to have more than one correct answer
    errors.add(:base, _("Mandatory quizzes should have ONLY ONE correct answer")) if correct_answers > 1 && quiz_page.is_mandatory?
  end
end
