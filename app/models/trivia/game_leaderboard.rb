# frozen_string_literal: true

# == Schema Information
#
# Table name: trivia_game_leaderboards
#
#  id             :bigint           not null, primary key
#  trivia_game_id :bigint
#  points         :integer
#  position       :integer
#  average_time   :integer          default(0)
#  person_id      :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  product_id     :integer          not null
#

module Trivia
  class GameLeaderboard < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, ->(product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :game, class_name: 'Trivia::Game', foreign_key: :trivia_game_id
    belongs_to :person, class_name: 'Person'
  end
end
