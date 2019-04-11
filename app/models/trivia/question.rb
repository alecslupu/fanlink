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

class Trivia::Question < ApplicationRecord
  belongs_to :round, class_name: "Trivia::Round", counter_cache: :question_count, foreign_key: :trivia_round_id
  has_many :available_answers, class_name: "Trivia::AvailableAnswer", foreign_key: :trivia_question_id
  has_many :leaderboards, class_name: "Trivia::QuestionLeaderboard", foreign_key: :trivia_question_id
  has_many :trivia_answers, class_name: "Trivia::Answer", foreign_key: :trivia_question_id
  enum status: %i[draft published locked closed]
end
