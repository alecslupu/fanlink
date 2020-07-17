# frozen_string_literal: true

# == Schema Information
#
# Table name: notification_device_ids
#
#  id                :bigint           not null, primary key
#  person_id         :integer          not null
#  device_identifier :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  device_type       :integer          default("unknown"), not null
#  not_registered    :boolean          default(FALSE), not null
#

require 'faker'

FactoryBot.define do
  factory :notification_device_id do
    person { create(:person) }
    sequence(:device_identifier) { |n| Faker::Crypto.sha1 + n.to_s }
  end
end
