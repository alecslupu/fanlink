FactoryBot.define do
  factory :product do
    transient do
      with_action_type false
    end
    sequence(:name) { |n| "Product #{n}" }
    sequence(:internal_name) { |n| "product#{n}" }
    enabled true

    after(:create) do |product, evaluator|
      if evaluator.with_action_type
        create(:action_type, product: product)
      end
    end
  end
end
