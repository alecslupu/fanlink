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
#  end_date     :datetime         default(Mon, 28 Jan 2019 16:43:52 UTC +00:00)
#  description  :jsonb            not null
#  product_id   :integer          not null
#

FactoryBot.define do
  factory :poll do
    poll_type { :post }
    poll_status { :active }
    product { current_product }
    start_date { DateTime.now + 1.hour }
    end_date { DateTime.now + 1.day }
    description { Faker::Lorem.paragraph(1) }
  end
end
