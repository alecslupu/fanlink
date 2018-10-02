require "faker"

FactoryBot.define do
  factory :interest do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    title { Faker::ProgrammingLanguage.name }
  end
end
