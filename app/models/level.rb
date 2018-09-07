class Level < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  has_paper_trail

  acts_as_tenant(:product)
  belongs_to :product

  has_image_called :picture
  has_manual_translated :description, :name

  validates :internal_name,
            presence: { message: _("Internal name is required.") },
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26, message: _("Internal name must be between 3 and 26 characters in length.") },
            uniqueness: { scope: :product_id, message: _("There is already a level with that internal name.") }

  validates :points, presence: { message: _("Point value is required.") },
            numericality: { greater_than: 0, message: _("Point value must be greater than zero.") },
            uniqueness: { scope: :product_id, message: _("There is already a level with that point value.") }
end
