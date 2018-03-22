class Merchandise < ApplicationRecord
  include AttachmentSupport

  has_image_called :picture

  acts_as_tenant(:product)

  has_paper_trail

  scope :listable, -> { where(available: true) }
end
