FactoryBot.define do
  factory :following do
    follower_id { create(:person).id }
    followed_id { create(:person).id }
  end
end
