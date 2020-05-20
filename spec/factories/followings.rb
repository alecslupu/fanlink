# frozen_string_literal: true
# == Schema Information
#
# Table name: followings
#
#  id          :bigint(8)        not null, primary key
#  follower_id :integer          not null
#  followed_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :following do
    follower { create(:person) }
    followed { create(:person) }
  end
end
