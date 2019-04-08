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
