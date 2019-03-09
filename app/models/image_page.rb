class ImagePage < CertcoursePage
  include AttachmentSupport

  has_course_image_called :attachment
  validates_attachment_presence :attachment
end
