require "faker"

FactoryBot.define do
  factory :person_interest do
    person { create(:person) }
    interest { create(:interest) }
  end
end
