FactoryBot.define do
  factory :relationship do
    requested { create(:person) }
    requested { create(:person) }
  end
end
