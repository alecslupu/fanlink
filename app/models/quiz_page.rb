class QuizPage < ApplicationRecord
  belongs_to :certcourse_page

  has_many :answers

  validate :just_me

  private

  def just_me
    x = CertcoursePage.find(certcourse_page.id)
    child = x.child
    if child && child != self
      errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
    end
  end
end
