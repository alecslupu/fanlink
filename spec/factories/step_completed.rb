FactoryBot.define do
  factory :step_completed do
    person { create(:person) }
    before(:create) do |step_completed|
      step_completed.quest_id = FactoryBot.create(:quest).id
      step_completed.step = FactoryBot.create(:step, quest_id: step_completed.quest_id)
    end
  end
end
