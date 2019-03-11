class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_course_image_called :image
  validates_attachment_presence :image

  validates_uniqueness_of :certcourse_page_id
  
  belongs_to :certcourse_page

  after_save :set_certcourse_page_content_type

  def product
    Product.find_by(internal_name: "caned")
  end

  private

  def set_certcourse_page_content_type
  	page = CertcoursePage.find(self.certcourse_page_id)
  	page.content_type = "image"
  	page.save
  end
end

