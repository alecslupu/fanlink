FactoryBot.define do
  factory :post do
    person { create(:person) }
    body { "MyText" }
    global { false }
  end
end
