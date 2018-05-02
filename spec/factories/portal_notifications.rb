FactoryBot.define do
  factory :portal_notification do
    person_id { create(:person).id }
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    body "My Notification"
    send_me_at { Time.now.end_of_hour }
  end
end
