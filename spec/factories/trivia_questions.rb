# == Schema Information
#
# Table name: trivia_questions
#
#  id                :bigint(8)        not null, primary key
#  start_date        :datetime
#  end_date          :datetime
#  trivia_package_id :bigint(8)
#  time_limit        :integer
#  type              :string
#  question_order    :integer          default(1), not null
#  status            :integer          default("draft"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_interval :integer          default(5)
#

FactoryBot.define do
  factory :trivia_question, class: "Trivia::Question" do
    start_date { "2019-04-01 22:39:26" }
    end_date { "2019-04-01 22:39:26" }
    points { 1 }
    trivia_package { nil }
    time_limit { 1 }
  end
end
