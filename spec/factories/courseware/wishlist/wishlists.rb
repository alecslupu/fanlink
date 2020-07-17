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


FactoryBot.define do
  factory :courseware_wishlist_wishlist, class: 'Courseware::Wishlist::Wishlist' do
    person { create(:person) }
    certificate { create(:certificate) }
  end
end
