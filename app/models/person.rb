class Person < ApplicationRecord
  authenticates_with_sorcery!

  acts_as_tenant(:product)

  belongs_to :product, required: true
end
