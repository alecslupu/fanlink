FactoryBot.define do
  factory :badge_award do
    person { create(:person) }
    badge { create(:badge) }
  end
end
