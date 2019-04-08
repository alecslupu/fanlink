FactoryBot.define do
  factory :relationship do
    requested_by { create(:person) }
    requested_to { create(:person) }
  end
end
