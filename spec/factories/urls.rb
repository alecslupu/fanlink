FactoryBot.define do
  factory :url do
    product { current_product }
    sequence(:displayed_url) { |n| "http://example.com/#{n}" }
  end
end
