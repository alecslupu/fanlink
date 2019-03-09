class QuizPage < ApplicationRecord
  belongs_to :certcourse_page

  has_many :answers

  validate :just_me
  after_save :set_certcourse_page_content_type

  private

  def just_me
    x = CertcoursePage.find(certcourse_page.id)
    child = x.child
    if child && child != self
      errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
    end
  end

  def set_certcourse_page_content_type
    page = CertcoursePage.find(self.certcourse_page_id)
    page.content_type = "quiz"
    page.save
  end
end
