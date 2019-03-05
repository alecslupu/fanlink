class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_image_called :image
  validates_attachment_presence :image
  
  belongs_to :certcourse_page
end
