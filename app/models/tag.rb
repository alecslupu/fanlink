class Tag < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product
  
  has_many :post_tags
  has_many :posts, through: :post_tags
end
