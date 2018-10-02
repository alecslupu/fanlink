require "faker"

FactoryBot.define do
  factory :person_interest do
    person_id { create(:person).id }
    interest_id { create(:interest).id }
  end
end
