# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_subscribers
#
#  id             :bigint           not null, primary key
#  person_id      :bigint
#  trivia_game_id :bigint
#  subscribed     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#

FactoryBot.define do
  factory :trivia_subscriber, class: 'Trivia::Subscriber' do
    product { current_product }

    person { create(:person) }
    game { create(:trivia_game) }
    subscribed { false }
  end
end
