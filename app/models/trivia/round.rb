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
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id, counter_cache: :round_count

    has_many :questions, -> { order("question_order") }, class_name: "Trivia::Question", foreign_key: :trivia_round_id, dependent: :destroy
    has_many :leaderboards, class_name: "RoundLeaderboard", foreign_key: :trivia_round_id, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true
    validate :check_start_date_when_publishing, on: :update, if: -> {published?}

    include AASM

    enum status: {
      draft: 0,
      published: 1,
      locked: 2,
      running: 3,
      closed: 4,
    }

    aasm(column: :status, enum: true, whiny_transitions: false, whiny_persistence: false, logger: Rails.logger) do
      state :draft, initial: true
      state :published
      state :locked
      state :running
      state :closed

      event :publish, guards: [:ceva] do
        # before do
        #   instance_eval do
        #     validates_presence_of :sex, :name, :surname
        #   end
        # end
        transitions from: :draft, to: :published
      end

      event :unpublish do
        transitions from: :published, to: :draft
      end

      event :locked do
        transitions from: :published, to: :locked
      end
      event :running do
        transitions from: :locked, to: :running
      end

      event :closed do
        transitions from: :running, to: :closed
      end
    end

    def status_enum
      new_record? ? [:draft] : aasm.states(permitted: true).map(&:name).push(status)
    end

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

    def ceva
      if start_date < Time.zone.now.to_i
        errors.add(:start_date, "Start date must be higher than current date")
        return false

      else
        return true
      end
    end

    def check_start_date_when_publishing
       errors.add(:start_date, "must be higher than current date.") if start_date < Time.zone.now.to_i
    end
  end
end
