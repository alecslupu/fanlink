# == Schema Information
#
# Table name: quiz_pages
#
#  id                   :bigint(8)        not null, primary key
#  certcourse_page_id   :integer
#  is_optional          :boolean          default(FALSE)
#  quiz_text            :string           default(""), not null
#  wrong_answer_page_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :integer          not null
#

class QuizPage < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :certcourse_page

  has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  validate :just_me
  validates :quiz_text, presence: true
  after_save :set_certcourse_page_content_type

  validate :mandatory_checks,  unless: Proc.new { |p| p.is_optional }
  validate :answer_checks


  def course_name
    certcourse_page.certcourse.to_s
  end

  def to_s
    quiz_text
  end

  alias :title :to_s

  private

    def just_me
      return if certcourse_page.new_record?

      x = CertcoursePage.find(certcourse_page.id)
      child = x.child
      if child && child != self
        errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
      end
    end

    def answer_checks
      corect_answers = answers.reject{|x| !x.is_correct}.size
      errors.add(:base, _("You need at least one correct answer")) if corect_answers.zero?
      # # FLAPI-876 [RailsAdmin] add validation for optional quizzes not to have more than one correct answer
      # # FLAPI-875 [RailsAdmin] o add validation for mandatory quizzes to not be able to have more than one correct answer
      # if answers.where(is_correct: true).size > 1
      #   # FLAPI-876
      # end
    end

    def mandatory_checks
      if wrong_answer_page_id.nil?
        errors.add(:base, :mandatory_checks, message: _("Mandatory quizes require a wrong answer page."))
      else
        wrong_page = CertcoursePage.where(id: wrong_answer_page_id).first
        errors.add(:wrong_answer_page_id, _("Could not find the specified Wrong page id")) unless wrong_page.present?
        if wrong_page.present? && wrong_page.certcourse_page_order >= certcourse_page.certcourse_page_order
          errors.add(:wrong_answer_page_id,  _("Wrong page needs to come before this page."))
        end
      end
    end

    def set_certcourse_page_content_type
      page = CertcoursePage.find(self.certcourse_page_id)
      page.content_type = "quiz"
      page.save
    end
end
