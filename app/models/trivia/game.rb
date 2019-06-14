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

      list do
        fields :id, :description, :round_count, :long_name, :status
        field :start_date, :unix_timestamp
      end

      edit do
        fields :short_name, :long_name, :description, :room, :leaderboard_size, :picture
        field :status, :enum do
          # read_only { bindings[:object].persisted? }
        end
        field :start_date, :unix_timestamp
        field :prizes do
          visible { bindings[:object].persisted? }
        end
        field :rounds do
          visible { bindings[:object].persisted? }
        end
      end
      show do
        fields :short_name, :long_name, :description, :room, :status, :leaderboard_size, :picture
        field :start_date, :unix_timestamp
        fields :prizes, :rounds
      end
    end

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

=begin
validates the startd_date > now when draft and published FLAPI-936

    validate :start_time_constraints
    def start_time_constraints
      if published?
        errors.add(:start_date) if start_date < DateTime.now.to_i
      end
    end
=end

    enum status: %i[draft published locked running closed]

    scope :enabled, -> { where(status: [ :published, :locked, :running, :closed ]) }
    scope :completed, -> { where(status: [ :closed ]).order(end_date: :desc).where("end_date < ?", DateTime.now.to_i) }
    scope :upcomming, -> { where(status: [ :published, :locked, :running ]).order(:start_date).where("end_date > ?", DateTime.now.to_i) }

    after_save :handle_status_changes

    def compute_gameplay_parameters
      ActiveRecord::Base.transaction do
        rounds.each.map(&:compute_gameplay_parameters)
        self.start_date =  rounds.first.start_date
        self.end_date = rounds.reload.last.end_date_with_cooldown
        self.save
      end
    end

    def handle_status_changes
      if saved_change_to_attribute?(:status) && published?
        Delayed::Job.enqueue(::Trivia::GameStatus::PublishJob.new(self.id))
      end
    end

  end
end

