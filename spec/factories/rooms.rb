FactoryBot.define do
  factory :room do
    product { Product.first || FactoryBot.create(:product) }
    sequence(:name) { |n| "Room #{n}" }
    created_by_id { (Person.first || create(:person)).id } #TODO admin user
  end
end
