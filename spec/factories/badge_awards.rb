FactoryBot.define do
  factory :badge_award do
    person_id { create(:person).id }
    badge_id { create(:badge).id }
  end
end
