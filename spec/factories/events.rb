# == Schema Information
#
# Table name: events
#
#  id               :bigint(8)        not null, primary key
#  product_id       :integer          not null
#  name             :text             not null
#  description      :text
#  starts_at        :datetime         not null
#  ends_at          :datetime
#  ticket_url       :text
#  place_identifier :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted          :boolean          default(FALSE), not null
#  latitude         :decimal(10, 6)
#  longitude        :decimal(10, 6)
#

FactoryBot.define do
  factory :event do
    product { current_product }
    sequence(:name) { |n| "Event #{n}" }
    starts_at { rand(3.days).seconds.from_now }
    description { Faker::Lorem.sentence }
    ticket_url { Faker::Internet.url }
    place_identifier { "fdA3434Bdfad34" + Faker::Number.number(digits: 2).to_s }

    factory :event_with_product do
      # product { create(:product) }
    end

    factory :past_event do
      starts_at { 1.month.ago }
    end

    factory :future_event do
      starts_at { 1.month.from_now }
    end
  end
end
