class ActionType < ApplicationRecord
  acts_as_tenant(:product)

  validates :internal_name,
            presence: true,
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26 },
            uniqueness: { scope: :product_id, message: "There is already an action type with that internal name." }

  validates :name,
            presence: true,
            length: { in: 3..36 },
            uniqueness: { scope: :product_id, message: "There is already an action type with that name." }
end
