FactoryBot.define do
  factory :block do
    blocker { create(:person) }
    blocked { create(:person) }
  end
end
