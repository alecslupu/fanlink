# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_quiz_page_answers
#
#  id           :bigint           not null, primary key
#  quiz_page_id :integer
#  description  :string           default(""), not null
#  is_correct   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :integer          not null
#

class Answer < Fanlink::Courseware::QuizPageAnswer

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("Answer is deprecated and may be removed from future releases, use  Fanlink::Courseware::QuizPageAnswer instead.")
    super
  end

  validate :answer_checks

  def to_s
    description
  end
  alias :title :to_s

  protected

  def answer_checks
    correct_answers = quiz_page.answers.reject { |answer| !answer.is_correct }.size
    errors.add(:base, _('You need at least one correct answer. The changes have not been saved. Please refresh and try again')) if correct_answers.zero?
    # FLAPI-875 [RailsAdmin] o add validation for mandatory quizzes to not be able to have more than one correct answer
    errors.add(:base, _('Mandatory quizzes should have ONLY ONE correct answer')) if correct_answers > 1 && quiz_page.is_mandatory?
  end
end
