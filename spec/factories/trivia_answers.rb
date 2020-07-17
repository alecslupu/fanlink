# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_answers
#
#  id                 :bigint           not null, primary key
#  person_id          :bigint
#  trivia_question_id :bigint
#  answered           :string
#  time               :integer
#  is_correct         :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#

FactoryBot.define do
  factory :trivia_answer, class: 'Trivia::Answer' do
    product { current_product }

    person { create(:person) }
    question { create(:trivia_single_choice_question) }
    answered { 'MyString' }
    time { Faker::Number.between from: 1, to: 2000 }

    factory :correct_trivia_answer do
      answered { question.available_answers.first.name }
    end

    factory :wrong_trivia_answer do
      answered { 'a wrong answer' }
    end
  end
end
