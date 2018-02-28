require "faker"

FactoryBot.define do
  factory :post_reaction do
    person { create(:person) }
    post { create(:post) }
    reaction { %w[ 1F600 1F601 1F602 ].sample }
  end
end
