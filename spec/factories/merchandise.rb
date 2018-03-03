FactoryBot.define do
  factory :merchandise do
    product { create(:product) }
    name "MyText"
    description "MyText"
    price "$14.00"
  end
end
