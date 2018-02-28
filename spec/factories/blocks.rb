FactoryBot.define do
  factory :block do
    blocker_id { create(:person).id }
    blocked_id { create(:person).id }
  end
end
