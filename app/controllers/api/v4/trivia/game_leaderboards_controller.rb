# frozen_string_literal: true

module Api
  module V4
    module Trivia
      class GameLeaderboardsController < ApiController
        def index
          @leaderboard = paginate(fetch_leaderboard)
          return_the @leaderboard, handler: :jb
        end

        def me
          @leaderboard = fetch_leaderboard.where(person_id: current_user.id).first_or_initialize
          return_the @leaderboard, handler: :jb
        end

        private

        def fetch_leaderboard
          ::Trivia::Game.find(params[:game_id]).leaderboards
        end
      end
    end
  end
end
