# frozen_string_literal: true

# == Schema Information
#
# Table name: person_poll_options
#
#  id             :bigint(8)        not null, primary key
#  person_id      :integer          not null
#  poll_option_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :person_poll_option do
    person { create(:person) }
    poll_option { create(:poll_option) }
  end
end
