# frozen_string_literal: true
# == Schema Information
#
# Table name: quest_completions
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  activity_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status_old  :text             default("0"), not null
#  step_id     :integer          not null
#  status      :integer          default("locked"), not null
#

FactoryBot.define do
  factory :quest_completion do
    person { create(:person) }
    quest_activity { create(:quest_activity)}
    step { create(:step) }
    before(:create) do |quest_completion|
      quest_completion.quest_activity.step = quest_completion.step
      quest_completion.quest_activity.save
    end
  end
end
