# frozen_string_literal: true

module Api
  module V4
    module Trivia
      class GamesController < ApiController
        def index
          @games = paginate(::Trivia::Game.upcomming, per_page: 100)
          # return_the @games, handler: :jb, using: :index
          render :index, handler: :jb
        end

        def completed
          @games = paginate(::Trivia::Game.completed, per_page: 100)
          render :index, handler: :jb
        end
      end
    end
  end
end
