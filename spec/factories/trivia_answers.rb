# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint(8)        not null, primary key
#  person_id          :bigint(8)
#  trivia_question_id :bigint(8)
#  answered           :string
#  time               :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_correct         :boolean          default(FALSE)
#

FactoryBot.define do
  factory :trivia_answer, class: "Trivia::Answer" do
    person { create(:person) }
    question { create(:trivia_question) }
    answered { "MyString" }
    time { Faker::Number.between 1, 2000 }

    factory :correct_trivia_answer do
      answered { question.available_answers.first.name }
    end

    factory :wrong_trivia_answer do
      answered { "a wrong answer" }
    end
  end
end
