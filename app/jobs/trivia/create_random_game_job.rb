# frozen_string_literal: true
module Trivia
  class CreateRandomGameJob < ApplicationJob
    queue_as :trivia

    def perform(product_id)
      product = Product.where(id: product_id).first

      ActsAsTenant.with_tenant(product) do
        game_generator = Trivia::GameGenerator.new
        game_generator.generate
        game_generator.promote!
      end
    end
  end
end
