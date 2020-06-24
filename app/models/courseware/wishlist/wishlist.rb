# frozen_string_literal: true

module Courseware
  module Wishlist
    class Wishlist < ApplicationRecord
      belongs_to :person
      belongs_to :certificate

      validates :certificate_id, uniqueness: { scope: %i[person_id] }
    end
  end
end
