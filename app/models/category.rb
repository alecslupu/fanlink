class Category < ApplicationRecord
    acts_as_tenant(:product)
    belongs_to :product
    has_many :post

    validates :name, uniqueness: { scope: :product_id, allow_nil: false, message: "A category already exists with this name." }
end