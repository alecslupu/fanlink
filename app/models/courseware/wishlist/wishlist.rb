# frozen_string_literal: true

module Courseware
  module Wishlist
    class Wishlist < ApplicationRecord
      has_paper_trail ignore: [:created_at, :updated_at]

      belongs_to :person
      belongs_to :certificate

      validates :certificate_id, uniqueness: { scope: %i[person_id] }
    end
  end
end
