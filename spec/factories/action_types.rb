# frozen_string_literal: true

# == Schema Information
#
# Table name: action_types
#
#  id                  :bigint           not null, primary key
#  name                :text             not null
#  internal_name       :text             not null
#  seconds_lag         :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :boolean          default(TRUE), not null
#  badge_actions_count :integer
#  badges_count        :integer
#

FactoryBot.define do
  factory :action_type do
    sequence(:name) { |n| "Action #{n}" }
    sequence(:internal_name) { |n| "action_#{n}" }
  end
end
