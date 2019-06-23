module Trivia
  class CreateRandomGameJob
    def perform
      product = Product.where(internal_name: 'caned').first

      ActsAsTenant.with_tenant(product) do
        game_generator = Trivia::GameGenerator.new
        game_generator.generate
        game_generator.promote!
      end
    end
    # def error(job, exception)
    #   if exception.is_a?(Mandrill::UnknownTemplateError)
    #     Delayed::Job.where(id: job.id).destroy_all
    #   end
    # end
  end
end
