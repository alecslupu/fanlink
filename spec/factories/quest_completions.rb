FactoryBot.define do
  factory :quest_completion do
    person { create(:person) }
    before(:create) do |quest_completion|
      quest_completion.step = FactoryBot.create(:step)
      quest_completion.activity_id = FactoryBot.create(:quest_activity, step: quest_completion.step).id
    end
  end
end
