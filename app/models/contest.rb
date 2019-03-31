class Contest < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  normalize_attributes :rules_url, :contest_url, with: [ :strip, :blank, :downcase ] do |value|
    value.present? && value.is_a?(String) ? value.downcase : value
  end

  validates :name,
            presence: { message: "Name is required" }
end
