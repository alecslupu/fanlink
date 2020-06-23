# frozen_string_literal: true

# == Schema Information
#
# Table name: message_reports
#
#  id         :bigint(8)        not null, primary key
#  message_id :integer          not null
#  person_id  :integer          not null
#  reason     :text
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'faker'

FactoryBot.define do
  factory :message_report do
    person { create(:person) }
    message { create(:message) }
    reason { Faker::Lorem.paragraph }
    status { 'pending' }
  end
end
