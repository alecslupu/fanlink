require "faker"

FactoryBot.define do
  factory :notification_device_id do
    person { create(:person) }
    sequence(:device_identifier) { |n| Faker::Crypto.sha1 + "#{n}" }
  end
end
