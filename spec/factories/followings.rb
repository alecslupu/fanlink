FactoryBot.define do
  factory :following do
    follower { create(:person) }
    followed { create(:person) }
  end
end
