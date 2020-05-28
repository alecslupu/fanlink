# frozen_string_literal: true
class Api::V3::LevelsController < Api::V2::LevelsController
  before_action :super_admin_only, only: %i[ create update destroy ]
  # **
  # @api {get} /levels Get all available levels.
  # @apiName GetLevels
  # @apiGroup Level
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of all levels available to be obtained.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "levels": [
  #       {
  #         "id": "123"
  #         "name": "Level One",
  #         "internal_name": "level_one",
  #         "description": "some level translated to current language",
  #         "points": 10,
  #         "picture_url": "http://example.com/images/14"
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  # *

  def index
    @levels = paginate(Level.order(:points))
    return_the @levels
  end

  def create
  end

  def update
  end

  def destroy
  end
end
