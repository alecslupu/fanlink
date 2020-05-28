# frozen_string_literal: true
# == Schema Information
#
# Table name: quest_completed
#
#  id         :bigint(8)        not null, primary key
#  quest_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :quest_completed do
    person { create(:person) }
    quest { create(:quest) }
  end
end
