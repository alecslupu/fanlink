require "faker"

FactoryBot.define do
  factory :message_report do
    person { create(:person) }
    message { create(:message) }
    reason { Faker::Lorem.paragraph(2) }
  end
end
