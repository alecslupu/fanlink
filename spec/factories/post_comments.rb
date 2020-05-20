# frozen_string_literal: true
# == Schema Information
#
# Table name: post_comments
#
#  id         :bigint(8)        not null, primary key
#  post_id    :integer          not null
#  person_id  :integer          not null
#  body       :text             not null
#  hidden     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "faker"

FactoryBot.define do
  factory :post_comment do
    person { create(:person) }
    post { create(:post) }
    body { Faker::Lorem.paragraph }
  end
end
