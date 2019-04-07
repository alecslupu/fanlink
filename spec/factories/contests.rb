require "faker"
I18n.reload!

FactoryBot.define do
  factory :contest do
    product { current_product }
    sequence(:name) { |n| "Contest #{n}" }
    sequence(:internal_name) { |n| "contest_#{n}" }
    description { Faker::Lorem.paragraph }
    rules_url { nil }
    contest_url { nil }
  end
end
