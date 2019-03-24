class Contest < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  normalize_attributes :rules_url, :contest_url, with: [:strip, :blank, :downcase]

  validates :name,
            presence: { message: "Name is required" }
end
