FactoryBot.define do
  factory :portal_notification do
    product { current_product}
    body { "My Notification" }
    send_me_at { Time.now.end_of_hour }
  end
end
