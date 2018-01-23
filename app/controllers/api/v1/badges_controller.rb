class Api::V1::BadgesController < ApiController
  #**
  # @api {get} /badges Get badges.
  # @apiName GetBadges
  # @apiGroup Badges
  #
  # @apiDescription
  #   This gets a list of all badges. Will include points earned towards each badge and whether badge has been awarded
  #   to the current user.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "pending_badges": [
  #       {
  #         badge_action_count: 1,
  #         badge_awarded: false,
  #         badge: { ...badge json ...}
  #       },...
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found, 422 Unprocessable, etc.
  #*
  def index
    @badges = Badge.all
    @badges_awarded = current_user.badge_awards.map { |ba| ba.badge }
    @badge_action_counts = current_user.badge_actions.group(:action_type_id).count
  end
end
