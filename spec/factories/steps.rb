# frozen_string_literal: true

# == Schema Information
#
# Table name: steps
#
#  id             :bigint(8)        not null, primary key
#  quest_id       :integer          not null
#  display        :text
#  deleted        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  int_unlocks    :integer          default([]), not null, is an Array
#  initial_status :integer          default("locked"), not null
#  reward_id      :integer
#  delay_unlock   :integer          default(0)
#  uuid           :uuid
#  unlocks        :text
#  unlocks_at     :datetime
#

FactoryBot.define do
  factory :step do
    sequence(:display) { |n| "Step #{n}" }
    uuid { UUIDTools::UUID.random_create.to_s }
    quest { create(:quest) }
  end
end
