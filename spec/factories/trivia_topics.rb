# == Schema Information
#
# Table name: trivia_topics
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#

FactoryBot.define do
  factory :trivia_topic, class: "Trivia::Topic" do
    product { current_product }

    name { Faker::Lorem.question(2) }
    status { :published }
  end
end
