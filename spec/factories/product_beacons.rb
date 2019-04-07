require "securerandom"
require "faker"

FactoryBot.define do
  factory :product_beacon do
    product { current_product}
    uuid { SecureRandom.uuid }
    beacon_pid { Faker::Device.serial }
    lower { 1 }
    upper { 2 }
  end
end
