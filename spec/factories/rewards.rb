FactoryBot.define do
  factory :reward do
    product { ActsAsTenant.current_tenant || FactoryBot.create(:product) }
    sequence(:name) { |n| "Reward #{n}" }
    sequence(:internal_name) { |n| "reward_#{n}" }

    factory :badge_reward do
      reward_type_id { create(:badge).id }
      reward_type { :badge }
    end

    factory :url_reward do
      reward_type_id { create(:url).id }
      reward_type { :url }
    end

    factory :coupon_reward do
      reward_type_id { create(:coupon).id }
      reward_type { :coupon }
    end

    trait :badge do
      reward_type { :badge }
    end

    trait :url do
      reward_type { :url }
    end

    trait :coupon do
      reward_type { :coupon }
    end

    trait :active do
      status { :active }
    end

    trait :inactive do
      status { :inactive }
    end
  end
end
