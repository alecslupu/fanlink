# frozen_string_literal: true
# == Schema Information
#
# Table name: poll_options
#
#  id                        :bigint(8)        not null, primary key
#  poll_id                   :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  description               :jsonb            not null
#  person_poll_options_count :integer
#

FactoryBot.define do
  factory :poll_option do
    poll { create(:poll) }
    description { Faker::Lorem.sentence }
  end
end
