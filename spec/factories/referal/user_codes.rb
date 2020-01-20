FactoryBot.define do
  factory :referral_user_code, class: 'Referral::UserCode' do
    person { create(:person) }
    unique_code { "MyString" }
  end
end
