# frozen_string_literal: true

# == Schema Information
#
# Table name: contests
#
#  id            :bigint(8)        not null, primary key
#  product_id    :integer          not null
#  name          :text             not null
#  internal_name :text
#  description   :text             not null
#  rules_url     :text
#  contest_url   :text
#  status        :integer          default(0)
#  deleted       :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "faker"
I18n.reload!

FactoryBot.define do
  factory :contest do
    product { current_product }
    sequence(:name) { |n| "Contest #{n}" }
    sequence(:internal_name) { |n| "contest_#{n}" }
    description { Faker::Lorem.paragraph }
    rules_url { nil }
    contest_url { nil }
  end
end
