# frozen_string_literal: true

# == Schema Information
#
# Table name: polls
#
#  id           :bigint(8)        not null, primary key
#  poll_type    :integer
#  poll_type_id :integer
#  start_date   :datetime         not null
#  duration     :integer          default(0), not null
#  poll_status  :integer          default("inactive"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  end_date     :datetime         default(Thu, 07 Feb 2019 01:46:08 UTC +00:00)
#  description  :jsonb            not null
#  product_id   :integer          not null
#

FactoryBot.define do
  factory :poll do
    start_date { DateTime.now + 1.day }
    end_date { DateTime.now + 2.day }
    description { Faker::Lorem.paragraph(sentence_count: 1) }
    product { current_product }
    poll_type { "post" }
    poll_status { :active }
    poll_type_id { create(:post).id }
  end
end
