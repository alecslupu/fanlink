FactoryBot.define do
  factory :url do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:displayed_url) { |n| "http://example.com/#{n}" }
  end
end