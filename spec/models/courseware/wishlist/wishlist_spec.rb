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


require 'rails_helper'

RSpec.describe Courseware::Wishlist::Wishlist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
