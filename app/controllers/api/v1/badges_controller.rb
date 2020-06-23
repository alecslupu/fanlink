# frozen_string_literal: true

module Api
  module V1
    class BadgesController < ApiController
      load_up_the Person, from: :person_id

      # **
      # @api {get} /badges Get badges for a passed in user.
      # @apiName GetBadges
      # @apiGroup Badges
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This gets a list of all badges earned for a passed in user. Will include points earned towards each badge and whether badge has been awarded
      #   to the user.
      #
      # @apiParam (body) {Integer} person_id
      #   The id of the person whose badges you want.
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #     "pending_badges": [
      #       {
      #         badge_action_count: 1,
      #         badge_awarded: false,
      #         badge: {
      #           "id": 123,
      #           "name": "Sheriff",
      #           "internal_name": "sheriff",
      #           "description": "You get this badge for just existing, in true millennial fashion",
      #           "picture_url": "http://example.com/images/14,
      #           "action_requirement": 1,
      #           "point_value": 5
      #         }
      #       },...
      #     ]
      #
      # @apiErrorExample {json} Error-Response:
      #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
      # *
      def index
        @badges = Badge.order(:id).all
        @badges_awarded = @person.badge_awards.map(&:badge)
        @badge_action_counts = @person.badge_actions.group(:action_type_id).count
        return_the @badges
      end
    end
  end
end
