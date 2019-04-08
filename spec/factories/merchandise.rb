FactoryBot.define do
  factory :merchandise do
    product { current_product }
    name { "MyText" }
    description { "MyText" }
    price { "$14.00" }
  end
end
