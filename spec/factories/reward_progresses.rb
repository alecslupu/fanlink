# frozen_string_literal: true

# == Schema Information
#
# Table name: reward_progresses
#
#  id         :bigint           not null, primary key
#  reward_id  :integer          not null
#  person_id  :integer          not null
#  series     :text
#  actions    :jsonb            not null
#  total      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :reward_progress do
    person { create(:person) }
    reward { create(:badge_reward) }
  end
end
