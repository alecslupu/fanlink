FactoryBot.define do
  factory :portal_access do
    person { create(:admin_user) }
  end
end
