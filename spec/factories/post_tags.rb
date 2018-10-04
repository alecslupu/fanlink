FactoryBot.define do
  factory :post_tag do
    post { create(:post) }
    tag { create(:tag) }
  end
end
