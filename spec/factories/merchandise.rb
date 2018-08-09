FactoryBot.define do
  factory :merchandise do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    name "MyText"
    description "MyText"
    price "$14.00"
  end
end
