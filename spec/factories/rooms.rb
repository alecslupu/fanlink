FactoryBot.define do
  factory :room do
    product { current_product}
    sequence(:name) { |n| "Room #{n}" }
    created_by_id { create(:person).id }

    factory :private_active_room do
      public { false }
      status { :active }
    end

    factory :public_active_room do
      public { true }
      status { :active }
    end
  end
end
