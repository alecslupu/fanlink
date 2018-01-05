require "faker"

FactoryBot.define do
  factory :message do
    person { create(:person) }
    room { create(:room) }
    body { Faker::Lorem::paragraph(2) }
  end
end
