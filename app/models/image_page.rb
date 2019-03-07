class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_image_called :image
  validates_attachment_presence :image
  
  belongs_to :certcourse_page

  before_save :set_certcourse_page_content_type

  def set_certcourse_page_content_type
  	page = CertcoursePage.find(self.certcourse_page_id)
  	page.content_type = "image"
  	page.save
  end
end
