module Courseware
  module Wishlist
    module PersonRelation
      extend ActiveSupport::Concern
      included do
        has_many :courseware_wishlists, class_name: "Courseware::Wishlist::Wishlist", inverse_of: :person
      end
    end
  end
end
