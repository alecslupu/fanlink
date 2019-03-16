FactoryBot.define do
  factory :certificate do
    long_name { "MyString" }
    short_name { "MyString" }
    description { "" }
    order { 1 }
    color_text { "MyString" }
    status { 1 }
    room { nil }
    is_free { false }
    sku_ios { "MyString" }
    sku_android { "MyString" }
    duration { 1 }
    image_filename { "MyString" }
    certificate_issued { false }
    unique_id { "MyString" }
  end
end
