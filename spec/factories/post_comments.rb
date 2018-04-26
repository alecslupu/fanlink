require "faker"

FactoryBot.define do
  factory :post_comment do
    person { create(:person) }
    post { create(:post) }
    body { Faker::Lorem.paragraph }
  end
end
