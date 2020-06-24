# frozen_string_literal: true

FactoryBot.define do
  factory :courseware_wishlist_wishlist, class: 'Courseware::Wishlist::Wishlist' do
    person { create(:person) }
    certificate { create(:certificate) }
  end
end
