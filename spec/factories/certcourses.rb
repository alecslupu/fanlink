# frozen_string_literal: true

# == Schema Information
#
# Table name: certcourses
#
#  id                     :bigint(8)        not null, primary key
#  long_name              :string           not null
#  short_name             :string           not null
#  description            :text             default(""), not null
#  color_hex              :string           default("#000000"), not null
#  status                 :integer          default("entry"), not null
#  duration               :integer          default(0), not null
#  is_completed           :boolean          default(FALSE)
#  copyright_text         :text             default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  product_id             :integer          not null
#  certcourse_pages_count :integer          default(0)
#

FactoryBot.define do
  factory :certcourse do
    product { current_product }
    long_name { Faker::Lorem.sentence(word_count: 3) }
    short_name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    color_hex { Faker::Color.hex_color }
    status { 1 }
    duration { 3600 }
    is_completed { false }
    copyright_text { Faker::Lorem.paragraph }
  end
end
