class Tag < ApplicationRecord
    acts_as_tenant(:product)
    belongs_to :product
    
end