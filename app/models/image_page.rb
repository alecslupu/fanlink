class ImagePage < CertcoursePage
  include AttachmentSupport

  has_image_called :attachment

end
