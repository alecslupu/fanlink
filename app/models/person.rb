class Person < ApplicationRecord
  authenticates_with_sorcery!

  acts_as_tenant(:product)
end
