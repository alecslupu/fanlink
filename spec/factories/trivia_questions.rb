# == Schema Information
#
# Table name: trivia_questions
#
#  id                :bigint(8)        not null, primary key
#  start_date        :datetime
#  end_date          :datetime
#  trivia_round_id   :bigint(8)
#  time_limit        :integer
#  type              :string
#  question_order    :integer          default(1), not null
#  status            :integer          default("draft"), not null
#  question_interval :integer          default(5)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :text
#

FactoryBot.define do
  factory :trivia_question, class: "Trivia::Question" do
    start_date { "2019-04-01 22:39:26" }
    end_date { "2019-04-01 22:39:26" }
    round { create(:trivia_round) }
    time_limit { 1 }
    title { Faker::Lorem.question(10)}

    after :create do |question|
      create :correct_trivia_available_answer, question: question
      create_list :wrong_trivia_available_answer, 3, question: question

      create_list :correct_trivia_answer, 3, question: question
      create_list :wrong_trivia_answer, 3, question: question

      question.trivia_answers.find_each do |ta|
        create :trivia_question_leaderboard, person: ta.person,  question: question
      end
    end
  end
end
