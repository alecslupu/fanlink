# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_topics
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :integer          not null
#

FactoryBot.define do
  factory :trivia_topic, class: 'Trivia::Topic' do
    product { current_product }

    name { Faker::Lorem.question(word_count: 2) }
    status { :published }
  end
end
