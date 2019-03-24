FactoryBot.define do
  factory :certcourse_page do
    certcourse { create(:certcourse) }
    certcourse_page_order { Faker::Number.unique.between(1, 500) }
    duration { 1 }
    background_color_hex { Faker::Color.hex_color }
    product { ActsAsTenant.current_tenant || Product.first || create(:product) }

  end
end
