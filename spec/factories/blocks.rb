# == Schema Information
#
# Table name: blocks
#
#  id         :bigint(8)        not null, primary key
#  blocker_id :integer          not null
#  blocked_id :integer          not null
#  created_at :datetime         not null
#

FactoryBot.define do
  factory :block do
    blocker { create(:person) }
    blocked { create(:person) }
  end
end
