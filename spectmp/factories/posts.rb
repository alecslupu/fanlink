FactoryBot.define do
  factory :post do
    person_id { create(:person).id }
    body "MyText"
    global false
  end
end
