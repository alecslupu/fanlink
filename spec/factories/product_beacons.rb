require "securerandom"
require "faker"

FactoryBot.define do
  factory :product_beacon do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    uuid { SecureRandom.uuid }
    beacon_pid { Faker::Device.serial }
  end
end