class Courseware::Wishlist::Wishlist < ApplicationRecord
  belongs_to :person
  belongs_to :certificate

  validates :certificate_id, uniqueness: { scope: %i[ person_id ] }
end
