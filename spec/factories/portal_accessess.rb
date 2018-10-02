FactoryBot.define do
  factory :portal_access do
    person { create(:person) }
  end
end
