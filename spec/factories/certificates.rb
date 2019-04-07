FactoryBot.define do
  factory :certificate do
    product { current_product }

    long_name { Faker::Lorem.name }
    short_name { Faker::Lorem.sentence(4) }
    description { Faker::Lorem.paragraph }
    color_hex { Faker::Color.hex_color }
    status { 1 }
    room { nil }
    certificate_order {  Faker::Number.unique(20).between(1, 500) }
    is_free { false }
    sku_ios { Faker::Code.ean(13) }
    sku_android { Faker::Code.ean(13) }
    template_image_file_name { Faker::File.file_name }
    certificate_issuable { false }
  end
end
