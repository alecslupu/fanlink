class Interest < ApplicationRecord
  include TranslationThings
  has_manual_translated :title

  acts_as_tenant(:product)

  belongs_to :product
  has_many :children, :class_name => 'Interest', :foreign_key => 'parent_id'

  validates :title, presence: { message: "Title is required" }

  scope :interests, -> (product) { where(product_id: product.id, parent_id: nil) }

end
