# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_quiz_pages
#
#  id                   :bigint           not null, primary key
#  course_page_id       :integer
#  is_optional          :boolean          default(FALSE)
#  quiz_text            :string           default(""), not null
#  wrong_answer_page_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :integer          not null
#  is_survey            :boolean          default(FALSE)
#

class QuizPage < Fanlink::Courseware::QuizPage

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("QuizPage is deprecated and may be removed from future releases, use Fanlink::Courseware::QuizPage instead.")
    super
  end

  accepts_nested_attributes_for :answers, allow_destroy: true

  validate :just_me
  validates :quiz_text, presence: true

  validate :mandatory_checks, unless: Proc.new { |page| page.is_optional }
  validate :answer_checks, unless: Proc.new { |page| page.is_survey }

  validates :is_optional, presence: {
    message: 'You have set the quiz survey, you must choose to be optional as well'
  }, if: :is_survey?

  validates :answers, presence: true, length: {
    minimum: 2,
    tokenizer: lambda { |assoc| assoc.size },
    too_short: 'must have at least %{count} entries',
    too_long: 'must have at most %{count} entries'
  }

  def course_name
    certcourse_page.certcourse.to_s
  end

  def to_s
    quiz_text
  end
  alias :title :to_s

  def is_mandatory?
    !is_optional?
  end

  def content_type
    :quiz
  end

  private

  def just_me
    return if course_page.new_record?

    target_course_page = CertcoursePage.find(course_page.id)
    child = target_course_page.child
    if child && child != self
      errors.add(:base, :just_me, message: _('A page can only have one of video, image, or quiz'))
    end
  end

  def answer_checks
    correct_answers = answers.reject { |answer| !answer.is_correct }.size
    errors.add(:base, _('You need at least one correct answer. The changes have not been saved. Please refresh and try again')) if correct_answers.zero?
    # FLAPI-875 [RailsAdmin] o add validation for mandatory quizzes to not be able to have more than one correct answer
    errors.add(:base, _('Mandatory quizzes should have ONLY ONE correct answer')) if correct_answers > 1 && is_mandatory?
  end

  def mandatory_checks
    if wrong_answer_page_id.nil?
      errors.add(:base, :mandatory_checks, message: _('Mandatory quizes require a wrong answer page.'))
    else
      wrong_page = CertcoursePage.where(id: wrong_answer_page_id).first
      errors.add(:wrong_answer_page_id, _('Could not find the specified Wrong page id')) if wrong_page.blank?
      if wrong_page.present? && wrong_page.course_page_order >= course_page.course_page_order
        errors.add(:wrong_answer_page_id, _('Wrong page needs to come before this page.'))
      end
    end
  end
end
