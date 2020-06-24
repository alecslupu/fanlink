# frozen_string_literal: true

module Api
  module V4
    module Trivia
      class PictureAvailableAnswersController < ApiController
        skip_before_action :require_login, only: %i[show]
        skip_before_action :set_product, only: %i[show]

        def show
          @answer = ::Trivia::PictureAvailableAnswer.find(params[:id])
          return_the @answer, handler: tpl_handler
        end

        def tpl_handler
          :jb
        end
      end
    end
  end
end
