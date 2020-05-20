# frozen_string_literal: true
# == Schema Information
#
# Table name: badge_actions
#
#  id             :bigint(8)        not null, primary key
#  action_type_id :integer          not null
#  person_id      :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identifier     :text
#

FactoryBot.define do
  factory :badge_action do
    action_type { create(:action_type) }
    person { create(:person) }
  end
end
