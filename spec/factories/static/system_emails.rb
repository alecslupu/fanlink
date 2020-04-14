FactoryBot.define do
  factory :static_system_email, class: 'Static::SystemEmail' do
    name { "MyString" }
    product { nil }
  end
end
