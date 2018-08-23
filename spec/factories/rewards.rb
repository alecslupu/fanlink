FactoryBot.define do
  factory :reward do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Reward #{n}" }
    sequence(:internal_name) { |n| "reward_#{n}" }
    reward_type_id { create(:badge).id }
    reward_type { "Badge" }
  end
end