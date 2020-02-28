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
#  product_id       :integer          not null
#

module Trivia
  class Round < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id, counter_cache: :round_count

    has_many :questions, -> { order("question_order") }, class_name: "Trivia::Question", foreign_key: :trivia_round_id, dependent: :destroy
    has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    enum status: %i[draft published locked running closed]

    scope :visible, -> { where(status: [:published, :locked, :running, :closed]) }

    def compute_leaderboard
      self.class.connection.execute("select compute_trivia_round_leaderboard(#{id})") if closed?
    end

    def compute_gameplay_parameters
      date_to_set = start_date
      questions.each_with_index do |question, index|
        question.start_date = date_to_set
        question.set_order(1 + index)
        question.compute_gameplay_parameters
        date_to_set = question.end_date_with_cooldown
      end
      self.end_date = questions.reload.last.end_date
      save
    end

    def end_date_with_cooldown
      end_date
    end

    # administrate fallback
    def game_id
      trivia_game_id
    end
  end
end
