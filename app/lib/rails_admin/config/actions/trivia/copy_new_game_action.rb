module RailsAdmin
  module Config
    module Actions
      module Trivia
        class CopyNewGameAction < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)

          register_instance_option :collection do
            false
          end

          register_instance_option :member do
            true
          end

          register_instance_option :link_icon do
            'icon-folder-open'
          end

          register_instance_option :route_fragment do
            'copy_new'
          end

          register_instance_option :controller do
            proc do
              Delayed::Job.enqueue(::Trivia::CopyGameJob.new(@object.id))

              flash[:notice] = "Game copied"
              redirect_to action: :index
            end
          end

        end
      end
    end
  end
end
