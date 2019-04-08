FactoryBot.define do
  factory :certcourse do
    product { current_product }
    long_name { Faker::Lorem.name }
    short_name { Faker::Lorem.sentence(4) }
    description { Faker::Lorem.paragraph }
    color_hex { Faker::Color.hex_color }
    status { 1 }
    duration { 3600 }
    is_completed { false }
    copyright_text { Faker::Lorem.paragraph }
  end
end
