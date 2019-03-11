class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_course_image_called :image
  validates_attachment_presence :image

  validates_uniqueness_of :certcourse_page_id
  
  belongs_to :certcourse_page
  has_course_image_called :image

  validates_attachment_presence :image
  after_save :set_certcourse_page_content_type
  validate :just_me

  def product
    Product.find_by(internal_name: "caned")
  end

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
    page.content_type = "image"
    page.save
  end
end

