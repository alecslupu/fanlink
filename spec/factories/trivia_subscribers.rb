# == Schema Information
#
# Table name: trivia_subscribers
#
#  id             :bigint(8)        not null, primary key
#  person_id      :bigint(8)
#  trivia_game_id :bigint(8)
#  subscribed     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :trivia_subscriber, class: "Trivia::Subscriber" do

    person { create(:person) }
    game { create(:trivia_game) }
    subscribed { false }
  end
end
