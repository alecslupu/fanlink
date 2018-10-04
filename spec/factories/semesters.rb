require "faker"
I18n.reload!

FactoryBot.define do
  factory :semester do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Semester #{n}" }
    description { Faker::Lorem.paragraph }
    start_date { DateTime.current }
  end
end
