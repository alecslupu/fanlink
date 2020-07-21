# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_course_pages
#
#  id                   :bigint           not null, primary key
#  course_id            :integer
#  course_page_order    :integer          default(0), not null
#  duration             :integer          default(0), not null
#  background_color_hex :string           default("#000000"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_type         :string
#  product_id           :integer          not null
#

FactoryBot.define do
  factory :certcourse_page, class: 'Fanlink::Courseware::CoursePage' do
    course { create(:certcourse) }
    sequence(:course_page_order) { |n| n }
    duration { 1 }
    background_color_hex { Faker::Color.hex_color }
    product { current_product }
  end
end
