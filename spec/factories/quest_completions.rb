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
    before(:create) do |quest_completion|
      quest_completion.step = FactoryBot.create(:step)
      quest_completion.activity_id = FactoryBot.create(:quest_activity, step: quest_completion.step).id
    end
  end
end
