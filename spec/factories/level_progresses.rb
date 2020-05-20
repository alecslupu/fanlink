# frozen_string_literal: true
# == Schema Information
#
# Table name: level_progresses
#
#  id        :bigint(8)        not null, primary key
#  person_id :integer          not null
#  points    :jsonb            not null
#  total     :integer          default(0), not null
#

FactoryBot.define do
  factory :level_progress do
    person { create(:person) }
  end
end
