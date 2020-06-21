# frozen_string_literal: true

FactoryBot.define do
  factory :room_subscriber do
    room { nil }
    person { nil }
    last_message { nil }
    last_notification_time { "2019-12-01 19:48:42" }
  end
end
