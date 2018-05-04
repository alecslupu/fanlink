FactoryBot.define do
  factory :badge_action do
    action_type { create(:action_type) }
    person { create(:person) }
  end
end
