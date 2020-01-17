FactoryBot.define do
  factory :referal_user_code, class: 'Referal::UserCode' do
    person { create(:person) }
    unique_code { "MyString" }
  end
end
