class Level < ApplicationRecord
  include AttachmentSupport
  has_paper_trail

  acts_as_tenant(:product)

  has_image_called :picture

  validates :internal_name,
            presence: true,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26 },
            uniqueness: { scope: :product_id, message: "There is already a level with that internal name." }

  validates :name,
            presence: true,
            length: { in: 3..36 },
            uniqueness: { scope: :product_id, message: "There is already a level with that name." }

  validates :points, presence: { message: "Point value is required." },
            numericality: { greater_than: 0, message: "Point value must be greater than zero." },
            uniqueness: { scope: :product_id, message: "There is already a level with that point value." }
end
