# == Schema Information
#
# Table name: step_unlocks
#
#  id        :bigint(8)        not null, primary key
#  step_id   :uuid             not null
#  unlock_id :uuid             not null
#

FactoryBot.define do
  factory :step_unlock do
    step_id { create(:step).uuid }
    unlock_id { create(:step).uuid }
  end
end
