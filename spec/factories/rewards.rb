# frozen_string_literal: true

# == Schema Information
#
# Table name: rewards
#
#  id                     :bigint(8)        not null, primary key
#  product_id             :integer          not null
#  name                   :jsonb            not null
#  internal_name          :text             not null
#  reward_type            :integer          default("badge"), not null
#  reward_type_id         :integer          not null
#  series                 :text
#  completion_requirement :integer          default(1), not null
#  points                 :integer          default(0)
#  status                 :integer          default("active"), not null
#  deleted                :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryBot.define do
  factory :reward do
    product { current_product }
    sequence(:name) { |n| "Reward #{n}" }
    sequence(:internal_name) { |n| "reward_#{n}" }

    factory :badge_reward do
      reward_type_id { create(:badge).id }
      reward_type { :badge }
      callback(:before_create, :after_build) do
        Reward.find_by(reward_type_id: Badge.last.id)&.destroy # because a reward is created when the badge is created
      end
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
