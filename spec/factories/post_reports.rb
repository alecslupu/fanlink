# frozen_string_literal: true

# == Schema Information
#
# Table name: post_reports
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  person_id  :integer          not null
#  reason     :text
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "faker"

FactoryBot.define do
  factory :post_report do
    person { create(:person) }
    post { create(:post) }
    reason { Faker::Lorem.paragraph }
  end
end
