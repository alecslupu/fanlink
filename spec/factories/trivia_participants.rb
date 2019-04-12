# == Schema Information
#
# Table name: trivia_participants
#
#  id             :bigint(8)        not null, primary key
#  person_id      :bigint(8)
#  trivia_game_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :trivia_participant, class: "Trivia::Participant" do
    person { nil }
    trivia_game { nil }
  end
end
