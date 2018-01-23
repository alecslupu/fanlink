class Api::V1::BadgeActionsController < ApiController

  before_action :load_action_type

  #**
  # @api {post} /posts Create a badge action.
  # @apiName CreateBadgeAction
  # @apiGroup Badges
  #
  # @apiDescription
  #   This creates a badge action. A badge action is a record of something done of a particular action type in the app.
  #   Badge actions are earned toward unearned badges of the action type matching the badge action. This call returns
  #   either an array of earned badges or an object called pending_badge with the points earned so far and the badge info.
  #   If more than one badge has been partially earned, the badge with the highest percentage earned is returned.
  #
  # @apiParam {Object} badge_action
  #   The badge_action object container.
  #
  # @apiParam {String} badge_action.action_type
  #   The internal name of the badge action.
  #
  # @apiSuccessExample Success-Response:
  #     HTTP/1.1 200 Ok
  #     badges_awarded: { [badge json], [badge_json],...} OR
  #     pending_badge: {
  #         badge_action_count: 1,
  #         badge: [ badge json]
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 422
  #     "errors" :
  #       { "Action type invalid, blah blah blah" }
  #*
  def create
    badge_action = current_user.badge_actions.create(action_type: @action_type)
    @badge_awards = {}
    if badge_action.valid?
      @badge_awards = BadgeAward.award_badges(badge_action)
    end
    return_the @badge_awards
  end

private

  def load_action_type
    if params[:badge_action].blank? || params[:badge_action][:action_type].blank?
      render_error("You must supply a badge action type.")
    else
      @action_type = ActionType.find_by(internal_name: params[:badge_action][:action_type])
      render_error("Action type is invalid.") unless @action_type.present?
    end
  end
end