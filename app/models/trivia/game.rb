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

    rails_admin do
      edit do
        fields :short_name, :long_name, :description, :room, :leaderboard_size, :picture
        field :status, :enum do
          read_only { bindings[:object].persisted? }
        end
        field :start_date, :unix_timestamp
        field :prizes do
          visible { bindings[:object].persisted? }
        end
        field :rounds do
          visible { bindings[:object].persisted? }
        end

        field :compute_gameplay, :boolean do
          read_only { bindings[:object].persisted? }
        end
      end
      show do
        fields :short_name, :long_name, :description, :room, :status, :leaderboard_size, :picture
        field :start_date, :unix_timestamp
        fields :prizes, :rounds
      end
    end

    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    attr_accessor :compute_gameplay
    include AttachmentSupport
    has_image_called :picture

    acts_as_tenant(:product)
    belongs_to :room, class_name: "Room", optional: true
    has_many :prizes, class_name: "Trivia::Prize", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :rounds, -> { order(:start_date) }, class_name: "Round", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :leaderboards, class_name: "Trivia::GameLeaderboard", foreign_key: :trivia_game_id, dependent: :destroy
    has_many :subscribers, class_name: "Trivia::Subscriber", foreign_key: :trivia_game_id, dependent: :destroy

    accepts_nested_attributes_for :prizes, allow_destroy: true
    accepts_nested_attributes_for :rounds, allow_destroy: true

    validates :long_name, presence: true
    validates :short_name, presence: true

    enum status: %i[draft published locked running closed]

    scope :enabled, -> { where(status: [ :published, :locked, :running, :closed ]) }
    scope :completed, -> { where(status: [ :closed ]).order(end_date: :desc).where("end_date < ?", DateTime.now.to_i) }
    scope :upcomming, -> { where(status: [ :published, :locked, :running ]).order(:start_date).where("end_date > ?", DateTime.now.to_i) }

    after_save :promote_status_changes
    before_save do
      self.compute_gameplay_parameters if self.compute_gameplay && self.rounds.size > 0
      self.compute_gameplay = false
    end

    def compute_gameplay_parameters
      ActiveRecord::Base.transaction do
        rounds.each.map(&:compute_gameplay_parameters)
        self.start_date =  rounds.first.start_date
        self.end_date = rounds.reload.last.end_date_with_cooldown
        self.save
        Delayed::Job.enqueue(::Trivia::LockGameJob.new(self.id), run_at: Time.at(self.start_date) - 10.minute)
        Delayed::Job.enqueue(::Trivia::RunningGameJob.new(self.id), run_at: Time.at(self.start_date))
        Delayed::Job.enqueue(::Trivia::CloseGameJob.new(self.id), run_at: Time.at(self.end_date))
      end
    end

    def promote_status_changes
      if saved_change_to_attribute?(:status) && locked?
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(self.id), run_at: 1.minute.from_now)
      end
    end
  end
end

