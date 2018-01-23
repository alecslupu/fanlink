class Api::V1::BadgeActionsController < ApiController

  before_action :load_action_type

  #**
  # @api {post} /posts Create an badge action.
  # @apiName CreateBadgeAction
  # @apiGroup Badges
  #
  # @apiDescription
  #   This creates an action. An action is a record of something done of a particular action type in the app. Actions
  #   are earned toward unearned badges of the action type matching the action. This call returns an array of badges.
  #   Either all of the badges earned by virtue of this new action or, if none, the one badge which has the highest
  #   percent completed of all badges assigned this action type.
  #
  # @apiParam {Object} action
  #   The action object container.
  #
  # @apiParam {String} action.action_type
  #   The internal name of the action.
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