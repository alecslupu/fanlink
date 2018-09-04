FactoryBot.define do
  factory :relationship do
    requested_by_id { create(:person, product: current_product).id }
    requested_to_id { create(:person, product: current_product).id }
  end
end
