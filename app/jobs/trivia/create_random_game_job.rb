module Trivia
  class CreateRandomGameJob < Struct.new(:product_id)
    def perform
      product = Product.where(id: product_id).first

      ActsAsTenant.with_tenant(product) do
        game_generator = Trivia::GameGenerator.new
        game_generator.generate
        game_generator.promote!
      end
    end

    def queue_name
      :trivia
    end
  end
end
