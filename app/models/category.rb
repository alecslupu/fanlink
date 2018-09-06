class Category < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  has_many :posts

  normalize_attributes :color

  enum role: %i[normal product staff admin super_admin]

  validates :name,
            presence: { message: _("Name is required.") },
            length: { in: 3..26, message: _("Name must be between 3 and 26 characters.") },
            uniqueness: { scope: :product_id, allow_nil: false, message: _("A category already exists with this name.") }

  validates :color, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/, message: lambda { |*| _("Color must be a hexadecimal value.") } }

  scope :for_admin, -> { where(role: [:normal, :product, :staff, :admin]) }
  scope :for_user, -> { where(role: [:normal]) }
  scope :for_super_admin, -> { where(role: [:normal, :product, :staff, :admin, :super_admin]) }
  scope :for_product_account, -> { where(role: [:product]) }
end
