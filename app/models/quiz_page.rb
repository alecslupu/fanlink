class QuizPage < ApplicationRecord
  belongs_to :certcourse_page

  has_many :answers

  after_save :set_certcourse_page_content_type

  private

  def set_certcourse_page_content_type
  	page = CertcoursePage.find(self.certcourse_page_id)
  	page.content_type = "image"
  	page.save
  end
end
