require "faker"

FactoryBot.define do
  factory :post_reaction do
    person { create(:person) }
    post { create(:post) }
    reaction { %w[ happy sad angry insoucient ].sample }
  end
end
