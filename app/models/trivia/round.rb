# == Schema Information
#
# Table name: trivia_rounds
#
#  id               :bigint(8)        not null, primary key
#  question_count   :integer
#  trivia_game_id   :bigint(8)
#  leaderboard_size :integer          default(100)
#  status           :integer          default("draft"), not null
#  complexity       :integer          default(1)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  start_date       :integer
#  end_date         :integer
#

module Trivia
  class Round < ApplicationRecord
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

    has_many :questions, -> { order("question_order") }, class_name: "Trivia::Question", foreign_key: :trivia_round_id
    has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id

    enum status: %i[draft published locked closed]

    scope :published, -> { where(status: [:published, :locked, :closed]) }

    def compute_gameplay_parameters
      date_to_set = self.start_date
      self.questions.each_with_index do |question, index|
        question.start_date = date_to_set
        question.set_order(1 + index)
        question.compute_gameplay_parameters
        date_to_set = question.end_date_with_cooldown
      end
      self.end_date = self.questions.reload.last.end_date
      self.save
    end

    def end_date_with_cooldown
      self.end_date
    end

    # administrate fallback
    def game_id
      trivia_game_id
    end
  end
end
