class HackedMetric < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  has_many :action_types
  has_many :people
end
