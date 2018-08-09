require "faker"

FactoryBot.define do
  factory :post_comment_report do
    person { create(:person) }
    post_comment { create(:post_comment) }
    reason { Faker::Lorem.paragraph }
  end
end
