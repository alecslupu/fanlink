# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_wishlist_wishlists
#
#  id             :bigint           not null, primary key
#  person_id      :bigint
#  certificate_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#


module Courseware
  module Wishlist
    class Wishlist < ApplicationRecord
      belongs_to :person
      belongs_to :certificate

      validates :certificate_id, uniqueness: { scope: %i[person_id] }
    end
  end
end
