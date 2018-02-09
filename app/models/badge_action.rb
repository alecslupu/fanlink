class BadgeAction < ApplicationRecord
  belongs_to :action_type
  belongs_to :person

  validate :product_match

  validates :identifier, uniqueness: { scope: %i[ person_id action_type_id ],
                                       message: "Sorry, you cannot get credit for that action again." }, allow_nil: true

private

  def product_match
    if action_type.product_id != person.product_id
      errors.add(:base, "Product mismatch!")
    end
  end
end
