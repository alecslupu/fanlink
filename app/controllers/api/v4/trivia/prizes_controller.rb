# frozen_string_literal: true
module Api
  module V4
    module Trivia
      class PrizesController < ApiController
        def index
          @prizes = paginate(::Trivia::Game.find(params[:game_id]).prizes.visible)
          return_the @prizes, handler: :jb
        end
      end
    end
  end
end
