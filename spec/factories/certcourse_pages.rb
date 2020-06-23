# frozen_string_literal: true

# == Schema Information
#
# Table name: certcourse_pages
#
#  id                    :bigint(8)        not null, primary key
#  certcourse_id         :integer
#  certcourse_page_order :integer          default(0), not null
#  duration              :integer          default(0), not null
#  background_color_hex  :string           default("#000000"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  content_type          :string
#  product_id            :integer          not null
#

FactoryBot.define do
  factory :certcourse_page do
    certcourse { create(:certcourse) }
    sequence(:certcourse_page_order) { |n| n }
    duration { 1 }
    background_color_hex { Faker::Color.hex_color }
    product { current_product }
  end
end
