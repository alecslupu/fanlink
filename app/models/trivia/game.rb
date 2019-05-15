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
    include AttachmentSupport
    has_attached_file :picture

    acts_as_tenant(:product)
    belongs_to :product, class_name: "Product"
    belongs_to :room, class_name: "Room"
    has_many :rounds, -> { order(:start_date) }, class_name: "Round", foreign_key: :trivia_game_id
    has_many :prizes, class_name: "Trivia::Prize", foreign_key: :trivia_game_id
    has_many :leaderboards, class_name: "Trivia::GameLeaderboard", foreign_key: :trivia_game_id
    has_many :subscribers, class_name: "Trivia::Subscriber", foreign_key: :trivia_game_id

    enum status: %i[draft published locked closed]

    scope :enabled, -> { where(status: [ :published, :locked, :closed ]) }
    scope :completed, -> { enabled.order(end_date: :desc).where("end_date < ?", DateTime.now.to_i) }
    scope :upcomming, -> { enabled.order(:start_date).where("end_date > ?", DateTime.now.to_i) }


    def compute_gameplay_parameters
      date_to_set = self.start_date

      self.rounds.each_with_index do |round, index|
        round.start_date = date_to_set
        round.compute_gameplay_parameters
        date_to_set = round.end_date_with_cooldown
      end
      self.end_date = date_to_set
      self.save
    end
  end
end
