# frozen_string_literal: true

# == Schema Information
#
# Table name: room_memberships
#
#  id            :bigint(8)        not null, primary key
#  room_id       :integer          not null
#  person_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  message_count :integer          default(0), not null
#

FactoryBot.define do
  factory :room_membership do
    room { create(:room, public: false) }
    person { create(:person) }
  end
end
