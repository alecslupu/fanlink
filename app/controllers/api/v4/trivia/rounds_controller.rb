# frozen_string_literal: true

module Api
  module V4
    module Trivia
      class RoundsController < ApiController
        skip_before_action :require_login, only: %i[change_status]

        def index
          @packages = paginate(data_source)
          return_the @packages, handler: :jb
        end

        def change_status
          if params[:token] == %w[
            eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9
            eyJhdXRob3JpemF0aW9uIjoiRVJjRVQzenAifQ
            XvEudHy8vLVuZc5MlPfo8NmeSTSmhuynxXQT7PE2rBM
          ].join('.')
            round = data_source.find(params[:round_id])
            statuses = [:locked, :published, :running]
            if statuses.include?(params[:status].to_sym) && round.update_attribute(:status, params[:status])
              head :ok
            else
              render_422 round.errors
            end
          else
            render_401
          end
        end

        protected

        def data_source
          ::Trivia::Game.find(params[:game_id]).rounds.visible
        end
      end
    end
  end
end
