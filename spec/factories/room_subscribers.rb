# frozen_string_literal: true

# == Schema Information
#
# Table name: room_subscribers
#
#  id                     :bigint           not null, primary key
#  room_id                :bigint           not null
#  person_id              :bigint           not null
#  last_message_id        :bigint
#  last_notification_time :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


FactoryBot.define do
  factory :room_subscriber do
    room { nil }
    person { nil }
    last_message { nil }
    last_notification_time { '2019-12-01 19:48:42' }
  end
end
