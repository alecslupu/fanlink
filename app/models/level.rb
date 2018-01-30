class Level < ApplicationRecord
  include AttachmentSupport

  acts_as_tenant(:product)

  has_image_called :picture
end
