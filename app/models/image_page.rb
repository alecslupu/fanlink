class ImagePage < CertcoursePage
  include AttachmentSupport
  acts_as_tenant(:product)
  belongs_to :product

  has_course_image_called :image
  validates_attachment_presence :image

  validates_uniqueness_of :certcourse_page_id

  has_course_image_called :attachment
  validates_attachment_presence :attachment
end
