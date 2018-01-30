FactoryBot.define do
  factory :level do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    name "My Level"
    internal_name "my_level"
    points 1
  end
end
