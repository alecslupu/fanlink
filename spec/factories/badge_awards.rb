# frozen_string_literal: true

# == Schema Information
#
# Table name: badge_awards
#
#  id         :bigint(8)        not null, primary key
#  person_id  :integer          not null
#  badge_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :badge_award do
    person { create(:person) }
    badge { create(:badge) }
  end
end
