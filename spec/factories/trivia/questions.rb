# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_questions
#
#  id                    :bigint(8)        not null, primary key
#  trivia_round_id       :bigint(8)
#  time_limit            :integer
#  type                  :string
#  question_order        :integer          default(1), not null
#  cooldown_period       :integer          default(5)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  start_date            :integer
#  end_date              :integer
#  available_question_id :integer
#  product_id            :integer          not null
#

FactoryBot.define do
  factory :trivia_question, class: 'Trivia::Question' do
    product { current_product }

    start_date { '2019-04-01 22:39:26' }
    end_date { '2019-04-01 22:39:26' }
    round { create(:trivia_round) }
    time_limit { 1 }
    cooldown_period { 6 }
    available_question { create(:trivia_available_question, with_answers: with_answers) }
    sequence(:question_order) { |n| n }

    transient do
      with_leaderboard { false }
      with_answers { true }
    end

    after :create do |question, options|
      if options.with_answers || options.with_leaderboard
        create_list :correct_trivia_answer, 3, question: question
        create_list :wrong_trivia_answer, 3, question: question
      end

      if options.with_leaderboard
        question.trivia_answers.find_each do |ta|
          create :trivia_question_leaderboard, person: ta.person, question: question
        end
      end
    end

    factory :trivia_multiple_choice_question, class: 'Trivia::MultipleChoiceQuestion' do
      available_question { create(:trivia_multiple_choice_available_question, with_answers: with_answers) }
    end

    factory :trivia_single_choice_question, class: 'Trivia::SingleChoiceQuestion' do
      available_question { create(:trivia_single_choice_available_question, with_answers: with_answers) }
    end
    factory :trivia_picture_question, class: 'Trivia::PictureQuestion' do
      available_question { create(:trivia_picture_available_question, with_answers: with_answers) }
    end
    factory :trivia_boolean_choice_question, class: 'Trivia::BooleanChoiceQuestion' do
      available_question { create(:trivia_boolean_choice_available_question, with_answers: with_answers) }
    end
    factory :trivia_hangman_question, class: 'Trivia::HangmanQuestion' do
      available_question { create(:trivia_hangman_available_question, with_answers: with_answers) }
    end
  end
end
