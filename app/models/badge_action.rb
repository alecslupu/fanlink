class BadgeAction < ApplicationRecord
  belongs_to :action_type
  belongs_to :person

  validate :product_match

private

  def product_match
    if action_type.product_id != person.product_id
      errors.add(:base, "Product mismatch!")
    end
  end
end
