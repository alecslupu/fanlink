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
    poll_type { "post" }
    poll_type_id { rand(100)}
    start_date { DateTime.now + 1.day }
    end_date { start_date + 1.day }
    duration { 0 }
    description{ "Random description" }
    product_id { create(:product).id }

  end
end
