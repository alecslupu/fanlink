class Category < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  has_many :posts

  normalize_attributes :color

  enum role: %i[normal product staff admin super_admin]

  validates :name, uniqueness: { scope: :product_id, allow_nil: false, message: "A category already exists with this name." }

  scope :for_admin, -> { where(role: [:normal, :product, :staff, :admin]) }
  scope :for_user, -> { where(role: [:normal]) }
  scope :for_super_admin, -> { where(role: [:normal, :product, :staff, :admin, :super_admin]) }
  scope :for_product_account, -> { where(role: [:product]) }
end
