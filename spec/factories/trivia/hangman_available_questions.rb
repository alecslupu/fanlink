
FactoryBot.define do
  factory :trivia_hangman_available_question, class: "Trivia::HangmanAvailableQuestion" do
    product { current_product }

    title { Faker::Lorem.question(word_count: 10) }
    cooldown_period { 6 }
    time_limit { 10 }
    topic { create(:trivia_topic) }
    complexity { 1 }
    available_answers { build_list(:correct_trivia_available_answer, 1) }

    transient do
      with_answers { false }
    end
  end
end
