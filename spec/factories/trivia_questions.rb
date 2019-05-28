# == Schema Information
#
# Table name: trivia_questions
#
#  id                    :bigint(8)        not null, primary key
#  trivia_round_id       :bigint(8)
#  type                  :string
#  question_order        :integer          default(1), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  start_date            :integer
#  end_date              :integer
#  time_limit            :integer
#  cooldown_period       :integer          default(5)
#  available_question_id :integer
#

FactoryBot.define do
  factory :trivia_question, class: "Trivia::Question" do
    start_date { "2019-04-01 22:39:26" }
    end_date { "2019-04-01 22:39:26" }
    round { create(:trivia_round) }
    time_limit { 1 }
    cooldown_period { 4 }
    available_question { create(:trivia_available_question, with_answers: with_answers) }


    transient do
      with_leaderboard { false }
      with_answers { false }
    end

    after :create do |question, options|
      if options.with_answers || options.with_leaderboard
        create_list :correct_trivia_answer, 3, question: question
        create_list :wrong_trivia_answer, 3, question: question
      end

      if options.with_leaderboard
        question.trivia_answers.find_each do |ta|
          create :trivia_question_leaderboard, person: ta.person,  question: question
        end
      end
    end

    factory :trivia_multiple_choice_question, class: "Trivia::MultipleChoiceQuestion" do
    end
  end
end
