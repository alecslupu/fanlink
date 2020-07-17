# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comment_reports
#
#  id              :bigint           not null, primary key
#  post_comment_id :integer          not null
#  person_id       :integer          not null
#  reason          :text
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'faker'

FactoryBot.define do
  factory :post_comment_report do
    person { create(:person) }
    post_comment { create(:post_comment) }
    reason { Faker::Lorem.paragraph }
  end
end
