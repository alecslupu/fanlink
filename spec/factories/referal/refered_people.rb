# frozen_string_literal: true

FactoryBot.define do
  factory :referral_referred_person, class: 'Referral::ReferredPerson' do
    inviter { nil }
    invited { nil }
  end
end
