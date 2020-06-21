# frozen_string_literal: true
FactoryBot.define do
  factory :static_system_email, class: 'Static::SystemEmail' do
    name  { Faker::Lorem.sentence }
    product { current_product }
    html_template { Faker::Lorem.paragraph }
    text_template { Faker::Lorem.paragraph }
    sequence(:public) { true }
    subject { Faker::Lorem.sentence }
  end
end
