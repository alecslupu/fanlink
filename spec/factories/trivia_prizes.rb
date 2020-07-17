# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_prizes
#
#  id                 :bigint           not null, primary key
#  trivia_game_id     :bigint
#  status             :integer          default("draft"), not null
#  description        :text
#  position           :integer          default(1), not null
#  photo_file_name    :string
#  photo_file_size    :integer
#  photo_content_type :string
#  photo_updated_at   :string
#  is_delivered       :boolean          default(FALSE)
#  prize_type         :integer          default("digital")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :trivia_prize, class: 'Trivia::Prize' do
    game { create(:trivia_game) }
    product { current_product }

    description { Faker::Lorem.paragraph }
    sequence(:position) { |n| n }
    prize_type { :digital }
  end
end
