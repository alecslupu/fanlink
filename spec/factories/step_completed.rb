# frozen_string_literal: true
# == Schema Information
#
# Table name: step_completed
#
#  id         :bigint(8)        not null, primary key
#  step_id    :integer          not null
#  person_id  :integer          not null
#  status_old :text             default("0"), not null
#  quest_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("locked"), not null
#

FactoryBot.define do
  factory :step_completed do
    person { create(:person) }
    before(:create) do |step_completed|
      step_completed.quest_id = FactoryBot.create(:quest).id
      step_completed.step = FactoryBot.create(:step, quest_id: step_completed.quest_id)
    end
  end
end
