# frozen_string_literal: true
# == Schema Information
#
# Table name: trivia_games
#
#  id                   :bigint(8)        not null, primary key
#  description          :text             default(""), not null
#  round_count          :integer
#  long_name            :string           not null
#  short_name           :string           not null
#  room_id              :bigint(8)
#  product_id           :bigint(8)
#  status               :integer          default("draft"), not null
#  leaderboard_size     :integer          default(100)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  start_date           :integer
#  end_date             :integer
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

module Trivia
  class Game < ApplicationRecord

    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    include AttachmentSupport
    has_image_called :picture

    belongs_to :room, class_name: "Room", optional: true
    has_many :prizes, class_name: "Trivia::Prize", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :rounds, -> { order(:start_date) }, class_name: "Round", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :leaderboards, class_name: "Trivia::GameLeaderboard", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :subscribers, class_name: "Trivia::Subscriber", foreign_key: :trivia_game_id, dependent: :destroy

    accepts_nested_attributes_for :prizes, allow_destroy: true
    accepts_nested_attributes_for :rounds, allow_destroy: true

    validates :long_name, presence: true
    validates :short_name, presence: true
    validate :check_rounds_start_time, if: -> { published? }
    validates_numericality_of :start_date, only_integer: true, greater_than_or_equal_to: Proc.new { Time.zone.now.to_i }, if: -> { published? }

    def compute_leaderboard
      self.class.connection.execute("select compute_trivia_game_leaderboard(#{id})") if closed?
    end

    include AASM

    enum status: {
      draft: 0,
      published: 1,
      locked: 2,
      running: 3,
      closed: 4
    }

    aasm(column: :status, enum: true, whiny_transitions: false, whiny_persistence: false, logger: Rails.logger) do
      state :draft, initial: true
      state :published, before_enter: Proc.new { compute_gameplay_parameters }
      state :locked
      state :running
      state :closed

      event :publish do
        after do
          handle_status_changes
        end
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

    scope :enabled, -> { where(status: [ :published, :locked, :running, :closed ]) }
    scope :completed, -> { where(status: [ :closed ]).order(end_date: :desc).where("end_date < ?", DateTime.now.to_i) }
    scope :upcomming, -> { where(status: [ :published, :locked, :running ]).order(:start_date).where("end_date > ?", DateTime.now.to_i) }

    after_save :handle_status_changes, if: -> { status_changed_to_publish? }
    before_validation :compute_gameplay_parameters, if: -> { published? }

    def copy_to_new
      new_entry = self.dup
      new_entry.update!(status: :draft, start_date: nil, end_date: nil)

      new_entry.prizes = prizes.collect(&:copy_to_new)
      new_entry.rounds = rounds.collect(&:copy_to_new)
      new_entry.save
      self.class.reset_counters(id, :rounds, touch: true)
      self.class.reset_counters(new_entry.id, :rounds, touch: true)
      new_entry
    end

    def compute_gameplay_parameters
      ActiveRecord::Base.transaction do
        rounds.each.map(&:compute_gameplay_parameters)
        self.start_date = rounds.first.start_date
        self.end_date = rounds.reload.last.end_date_with_cooldown
      end
    end

    private

      def handle_status_changes
        game = Trivia::Game.find(self.id)

        ::Trivia::PublishToEngine.perform_later(game.id)
        ::Trivia::GameStatus::LockedJob.set(wait_until: Time.at(game.start_date) - 10.minutes).perform_later(game.id)
        ::Trivia::GameStatus::RunningJob.set(wait_until: Time.at(game.start_date)).perform_later(game.id)
        ::Trivia::GameStatus::CloseJob.set(wait_until: Time.at(game.end_date)).perform_later(game.id)

        game.rounds.each do |round|
          ::Trivia::RoundStatus::LockedJob.set(wait_until: Time.at(round.start_date) - 30.minutes).perform_later(round.id)
          ::Trivia::RoundStatus::RunningJob.set(wait_until: Time.at(round.start_date)).perform_later(round.id)
          ::Trivia::RoundStatus::CloseJob.set(wait_until: Time.at(round.end_date)).perform_later(round.id)
        end
      end

      def status_changed_to_publish?
        (saved_change_to_attribute?(:status) && published?) ? true : false
      end

      def check_start_date_when_publishing
         errors.add(:start_date, "must be higher than current date.") if is_valid_start_date?
      end

      def is_valid_start_date?
        start_date.nil? || start_date.to_i < Time.zone.now.to_i
      end

      def start_date_in_future?
        if is_valid_start_date?
          errors.add(:start_date, "must be higher than current date")
          return false
        else
          return true
        end
      end

      def check_rounds_start_time
        if rounds.where('start_date < ? ', (Time.zone.now).to_i).present?
          errors.add(:start_date, "of the rounds must be higher than current date" )
        end
      end
  end
end

