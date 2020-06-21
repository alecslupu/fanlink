# frozen_string_literal: true

# == Schema Information
#
# Table name: person_certcourses
#
#  id                     :bigint(8)        not null, primary key
#  person_id              :integer          not null
#  certcourse_id          :integer          not null
#  last_completed_page_id :integer
#  is_completed           :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryBot.define do
  factory :person_certcourse do
    person { create(:person) }
    certcourse { create(:certcourse) }
  end
end
