# == Schema Information
#
# Table name: trivia_round_leaderboards
#
#  id              :bigint(8)        not null, primary key
#  trivia_round_id :bigint(8)
#  points          :integer
#  position        :integer
#  person_id       :bigint(8)
#  average_time    :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Trivia

  class RoundLeaderboard < ApplicationRecord
    belongs_to :round, class_name: "Trivia::Round", foreign_key: :trivia_round_id
    belongs_to :person, class_name: "Person"
  end
end
