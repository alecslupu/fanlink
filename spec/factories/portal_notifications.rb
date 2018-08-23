FactoryBot.define do
  factory :portal_notification do
    product { ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product) }
    body { "My Notification" }
    send_me_at { Time.now.end_of_hour }
  end
end
