FactoryBot.define do
  factory :certificate_certcourse do
    product { current_product }
    certcourse { create(:certcourse) }
    certificate { create(:certificate) }
    certcourse_order { Faker::Number.unique(20).between(1, 500) }
  end
end
