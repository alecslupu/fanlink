# == Schema Information
#
# Table name: trivia_subscribers
#
#  id             :bigint(8)        not null, primary key
#  person_id      :bigint(8)
#  trivia_game_id :bigint(8)
#  subscribed     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module Trivia
  class Subscriber < ApplicationRecord

    has_paper_trail
    belongs_to :person
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

    def game_id
      trivia_game_id
    end

    rails_admin do

    end
  end
end
