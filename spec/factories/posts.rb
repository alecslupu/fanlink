FactoryBot.define do
  factory :post do
    person { create(:person) }
    body { Faker::Lorem.paragraph }
    global { false }

    factory :recommended_post do
      recommended { true }
    end

    factory :published_post do
      status { :published }
    end
  end
end
