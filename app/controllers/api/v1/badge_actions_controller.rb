# frozen_string_literal: true

module Api
  module V1
    class BadgeActionsController < ApiController
      before_action :load_action_type

      # **
      # @api {post} /badge_actions Create a badge action.
      # @apiName CreateBadgeAction
      # @apiGroup Badges
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This creates a badge action. A badge action is a record of something done of a particular action type in the app.
      #   Badge actions are earned toward unearned badges of the action type matching the badge action. This call returns
      #   either an array of earned badges or an object called pending_badge with the points earned so far and the badge info.
      #   If more than one badge has been partially earned, the badge with the highest percentage earned is returned.
      #
      # @apiParam (body) {Object} badge_action
      #   The badge_action object container.
      #
      # @apiParam (body) {String} badge_action.action_type
      #   The internal name of the badge action.
      #
      # @apiParam (body) {String} [badge_action.identifier]
      #   The identifier for this badge action.
      #
      # @apiSuccessExample Success-Response:
      #     HTTP/1.1 200 Ok
      #     badges_awarded: { [badge json], [badge_json],...} OR
      #     pending_badge: { //NULL if there are no pending badges
      #         badge_action_count: 1,
      #         badge: [ badge json]
      #     }
      #
      # @apiErrorExample {json} Error-Response:
      #     HTTP/1.1 422
      #     "errors" :
      #       { "Action type invalid, cannot do that action again, blah blah blah" }
      #     HTTP/1.1 429 - Not enough time since last submission of this action type
      #           or duplicate action type, person, identifier combination
      # *
      def create
        if @action_type.seconds_lag > 0 && current_user.badge_actions.where(action_type: @action_type).
           where('created_at > ?', Time.zone.now - @action_type.seconds_lag.seconds).exists?
          head :too_many_requests
        else
          badge_action = current_user.badge_actions.create(action_type: @action_type, identifier: params[:badge_action][:identifier])
          if badge_action.valid?
            @badge_awards = {}
            @badge_awards = BadgeAward.award_badges(badge_action)
            return_the @badge_awards
          else
            render_error(badge_action.errors)
          end
        end
      end

      private

      def load_action_type
        if params[:badge_action].blank? || params[:badge_action][:action_type].blank?
          render_error(_('You must supply a badge action type.'))
        else
          @action_type = ActionType.find_by(internal_name: params[:badge_action][:action_type])
          render_error('Action type is invalid.') if @action_type.blank?
        end
      end
    end
  end
end
