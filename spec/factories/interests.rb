require "faker"

FactoryBot.define do
  factory :interest do
    product { current_product }
    title { Faker::ProgrammingLanguage.name }
  end
end
