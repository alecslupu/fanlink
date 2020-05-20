# frozen_string_literal: true
# == Schema Information
#
# Table name: person_rewards
#
#  id         :bigint(8)        not null, primary key
#  person_id  :integer          not null
#  reward_id  :integer          not null
#  source     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted    :boolean          default(FALSE)
#

FactoryBot.define do
  factory :person_reward do
    reward { create(:badge_reward) }
    person { create(:person) }
    source { "Test" }
  end
end
