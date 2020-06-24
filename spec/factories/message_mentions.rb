# frozen_string_literal: true

# == Schema Information
#
# Table name: message_mentions
#
#  id         :bigint(8)        not null, primary key
#  message_id :integer          not null
#  person_id  :integer          not null
#  location   :integer          default(0), not null
#  length     :integer          default(0), not null
#

FactoryBot.define do
  factory :message_mention do
    message { create(:message) }
    person { create(:person) }
  end
end
