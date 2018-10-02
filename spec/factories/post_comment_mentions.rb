FactoryBot.define do
  factory :post_comment_mention do
    post_comment { create(:post_comment) }
    person { create(:person) }
  end
end
