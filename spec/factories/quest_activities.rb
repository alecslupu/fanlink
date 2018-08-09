FactoryBot.define do
  factory :quest_activity do
    hint { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    step { create(:step) }
  end
end