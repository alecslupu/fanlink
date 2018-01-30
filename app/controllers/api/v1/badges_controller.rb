class Api::V1::BadgesController < ApiController
  load_up_the Person, from: :person_id

  #**
  # @api {get} /badges Get badges for a passed in user.
  # @apiName GetBadges
  # @apiGroup Badges
  #
  # @apiDescription
  #   This gets a list of all badges earned for a passed in user. Will include points earned towards each badge and whether badge has been awarded
  #   to the user.
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
    @badges_awarded = @person.badge_awards.map { |ba| ba.badge }
    @badge_action_counts = @person.badge_actions.group(:action_type_id).count
  end
end
