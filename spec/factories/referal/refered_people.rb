FactoryBot.define do
  factory :referal_refered_person, class: 'Referal::ReferedPerson' do
    inviter { nil }
    invited { nil }
  end
end
