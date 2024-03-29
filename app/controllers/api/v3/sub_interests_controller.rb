# frozen_string_literal: true

module Api
  module V3
    class SubInterestsController < ApiController
      # **
      #
      # @api {get} /interests Get Interests
      # @apiName GetInterests
      # @apiGroup Interests
      # @apiVersion  3.0.0
      #
      #
      # @apiSuccess (200) {Object} Interests lists
      #
      # @apiParamExample  {type} Request-Example:
      # {
      #     property : value
      # }
      #
      #
      # @apiSuccessExample {type} Success-Response:
      # {
      #     property : value
      # }
      #
      #
      # *
      def index
        @sub_interests = SubInterest.all
        return_the @sub_interests
      end
    end
  end
end
