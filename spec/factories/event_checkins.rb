FactoryBot.define do
  factory :event_checkin do
    event { create(:event) }
    person { create(:person) }
  end
end
