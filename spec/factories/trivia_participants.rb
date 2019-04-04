FactoryBot.define do
  factory :trivia_participant, class: 'Trivia::Participant' do
    person { nil }
    trivia_game { nil }
  end
end
