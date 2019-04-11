# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  start_date       :datetime
#  end_date         :datetime
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  package_order    :integer          default(1), not null
#  status           :integer          default("draft"), not null
#  uuid             :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  complexity       :integer          default(1)
#

class Trivia::Round < ApplicationRecord
  belongs_to :game, class_name: "Trivia::Game", counter_cache: :round_count, foreign_key: :trivia_game_id

  has_many :questions, class_name: "Trivia::Question", foreign_key: :trivia_round_id
  has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id

  enum status: %i[draft published locked closed]

  scope :published, -> { where(status: [:published, :locked, :closed]) }
end
