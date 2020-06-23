# frozen_string_literal: true

# == Schema Information
#
# Table name: certificates
#
#  id                          :bigint(8)        not null, primary key
#  long_name                   :string           not null
#  short_name                  :string           not null
#  description                 :text             default(""), not null
#  certificate_order           :integer          not null
#  color_hex                   :string           default("#000000"), not null
#  status                      :integer          default("entry"), not null
#  room_id                     :integer
#  is_free                     :boolean          default(FALSE)
#  sku_ios                     :string           default(""), not null
#  sku_android                 :string           default(""), not null
#  validity_duration           :integer          default(0), not null
#  access_duration             :integer          default(0), not null
#  certificate_issuable        :boolean          default(FALSE)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  template_image_file_name    :string
#  template_image_content_type :string
#  template_image_file_size    :integer
#  template_image_updated_at   :datetime
#  product_id                  :integer          not null
#

FactoryBot.define do
  factory :certificate do
    product { current_product }

    long_name { Faker::Lorem.name }
    short_name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    color_hex { Faker::Color.hex_color }
    status { 1 }
    room { nil }
    validity_duration {  Faker::Number.unique(20).between(from: 1, to: 500) }
    access_duration {  Faker::Number.unique(20).between(from: 1, to: 500) }
    is_free { false }
    sku_ios { Faker::Code.ean( base:13) }
    sku_android { Faker::Code.ean( base:13) }
    template_image_file_name { Faker::File.file_name }
    certificate_issuable { false }
    sequence(:certificate_order) { |n| n }
  end
end
