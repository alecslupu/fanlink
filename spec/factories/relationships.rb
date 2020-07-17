# frozen_string_literal: true

# == Schema Information
#
# Table name: relationships
#
#  id              :bigint           not null, primary key
#  requested_by_id :integer          not null
#  requested_to_id :integer          not null
#  status          :integer          default("requested"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :relationship do
    requested_by { create(:person) }
    requested_to { create(:person) }
  end
end
