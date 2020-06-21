# frozen_string_literal: true

class Api::V4::Trivia::PictureAvailableAnswersController < ApiController
  skip_before_action :require_login, only: %i[ show ]
  skip_before_action :set_product, only: %i[ show ]

  def show
    #if params[:token] == "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRob3JpemF0aW9uIjoiRVJjRVQzenAifQ.XvEudHy8vLVuZc5MlPfo8NmeSTSmhuynxXQT7PE2rBM"
    @answer = ::Trivia::PictureAvailableAnswer.find(params[:id])
    return_the @answer, handler: tpl_handler
    #else
    #render_401
    #end
  end

  def tpl_handler
    :jb
  end
end
