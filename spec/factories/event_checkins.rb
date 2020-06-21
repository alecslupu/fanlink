# frozen_string_literal: true

# == Schema Information
#
# Table name: event_checkins
#
#  id         :bigint(8)        not null, primary key
#  event_id   :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :event_checkin do
    event { create(:event) }
    person { create(:person) }
  end
end
