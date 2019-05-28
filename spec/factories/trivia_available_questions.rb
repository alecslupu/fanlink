# == Schema Information
#
# Table name: trivia_available_questions
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  cooldown_period :integer
#  time_limit      :integer
#  status          :integer
#  type            :string
#  topic_id        :integer
#  complexity      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :trivia_available_question, class: 'Trivia::AvailableQuestion' do
    title { Faker::Lorem.question(10) }
    cooldown_period {5 }
    time_limit { 10 }
    topic { create(:trivia_topic) }
    complexity { 1 }

    transient do
      with_answers { false }
    end

    after :create do |question, options|
      create :correct_trivia_available_answer, question: question
      create_list :wrong_trivia_available_answer, 3, question: question
    end
  end
end
