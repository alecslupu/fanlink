FactoryBot.define do
  factory :trivia_game, class: 'Trivia::Game' do
    start_date { "2019-04-01 22:34:36" }
    end_date { "2019-04-01 22:34:36" }
    name { "MyString" }
    description { "" }
    package_count { 1 }
  end
end
