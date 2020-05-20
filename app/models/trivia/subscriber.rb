# frozen_string_literal: true
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
#  product_id     :integer          not null
#

module Trivia
  class Subscriber < ApplicationRecord
    acts_as_tenant(:product)
    scope :for_product, -> (product) { where(product_id: product.id) }

    has_paper_trail
    belongs_to :person
    belongs_to :game, class_name: "Trivia::Game", foreign_key: :trivia_game_id

    def game_id
      trivia_game_id
    end

    def subscribe_to_game_topic(person_id, game_id)
      Push::BasePush.new.subscribe_user_to_topic(person_id, game_id)
    end

    def unsubscribe_from_game_topic(person_id, game_id)
      Push::BasePush.new.unsubscribe_user_from_topic(person_id, game_id)
    end
  end
end
