class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_image_called :picture
  
  belongs_to :certcourse_page
end
