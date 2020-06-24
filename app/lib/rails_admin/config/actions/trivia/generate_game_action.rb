# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      module Trivia
        class GenerateGameAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :collection do
            true
          end

          register_instance_option :route_fragment do
            'generate'
          end
          register_instance_option :controller do
            proc do
              ::Trivia::CreateRandomGameJob.perform_later(ActsAsTenant.current_tenant.id)

              flash[:notice] = t('game enqueued')
              redirect_to action: :index
            end
          end
        end
      end
    end
  end
end
