# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons
#
#  id          :bigint(8)        not null, primary key
#  product_id  :integer          not null
#  code        :text             not null
#  description :text             not null
#  url         :text
#  deleted     :boolean          default(FALSE)
#

require 'faker'

FactoryBot.define do
  factory :coupon do
    product { current_product }
    sequence(:code) { |n| "Coupon-#{n}" }
    description { Faker::Lorem.paragraph }
  end
end
