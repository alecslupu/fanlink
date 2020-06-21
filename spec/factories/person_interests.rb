# frozen_string_literal: true

# == Schema Information
#
# Table name: person_interests
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  interest_id :integer          not null
#

require "faker"

FactoryBot.define do
  factory :person_interest do
    person { create(:person) }
    interest { create(:interest) }
  end
end
