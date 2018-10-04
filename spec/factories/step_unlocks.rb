FactoryBot.define do
  factory :step_unlock do
    step_id { create(:step).uuid }
    unlock_id { create(:step).uuid }
  end
end
