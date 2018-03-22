class Merchandise < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  has_image_called :picture
  has_manual_translated :description, :name

  acts_as_tenant(:product)

  has_paper_trail

  scope :listable, -> { where(available: true) }
end
