FactoryBot.define do
  factory :certificate_certcourse do
    product { create(:product) }
    certcourse { create(:certcourse) }
    certificate { create(:certificate) }
    certcourse_order { Faker::Number.between(1, 500) }
  end
end
