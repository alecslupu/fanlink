class Badge < ApplicationRecord
  include AttachmentSupport

  has_paper_trail
  acts_as_tenant(:product)

  belongs_to :action_type

  has_image_called :picture

  validates :internal_name,
            presence: true,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26 },
            uniqueness: { scope: :product_id, message: "There is already a badge with that internal name." }

  validates :name,
            presence: true,
            length: { in: 3..36 },
            uniqueness: { scope: :product_id, message: "There is already a badge with that name." }

  validates :action_requirement, presence: { message: "Action requirement is required." },
            numericality: { greater_than: 0, message: "Action requirement must be greater than zero." }
end
