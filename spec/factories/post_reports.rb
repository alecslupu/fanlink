require "faker"

FactoryBot.define do
  factory :post_report do
    person { create(:person) }
    post { create(:post) }
    reason { Faker::Lorem.paragraph }
  end
end
