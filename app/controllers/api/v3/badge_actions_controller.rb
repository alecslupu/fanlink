# frozen_string_literal: true


module Api
  module V3
    class BadgeActionsController < Api::V2::BadgeActionsController
      before_action :super_admin_only, only: %i[index show update destroy]
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
        if @rewards.any?
          @rewards.each do |reward|
            if @action_type.seconds_lag > 0 && current_user.reward_progresses.where(reward_id: reward.id).where('updated_at > ?', Time.zone.now - @action_type.seconds_lag.seconds).exists?
              head :too_many_requests
              break
            else
              next if PersonReward.exists?(person_id: current_user.id, reward_id: reward.id)
              badge_action = current_user.badge_actions.create(action_type: @action_type, identifier: params[:badge_action][:identifier])
              if badge_action.valid?
                @progress = RewardProgress.find_or_initialize_by(reward_id: reward.id, person_id: current_user.id)
                @progress.series = @action_type.internal_name || nil
                @progress.actions['badge_action'] ||= 0
                @progress.actions['badge_action'] += 1
                @progress.total ||= 0
                @progress.total += 1
                if @progress.present? && @progress.save
                  @series_total = RewardProgress.where(person_id: current_user.id, series: @action_type.internal_name).sum(:total) || @progress.total
                  broadcast(:reward_progress_created, current_user, @progress, @series_total)
                  return_the @progress
                else
                  if @progress.blank?
                    render json: {errors: {base: _('Reward does not exist for that action type.')}}, status: :not_found
                  else
                    render_422(@progress.errors)
                  end
                end
                break
              else
                render_error(badge_action.errors)
                break
              end
            end
          end
        end
      end

      # def index

      # end

      # def update

      # end

      # def destroy

      # end

      private

      def load_action_type
        if params[:badge_action].blank? || params[:badge_action][:action_type].blank?
          render_422(_('You must supply a badge action type.'))
        else
          @action_type = ActionType.find_by(internal_name: params[:badge_action][:action_type])
          if @action_type.present?
            # ,,, Gross hack for now
            HackedMetric.create(
              person_id: current_user.id,
              product_id: ActsAsTenant.current_tenant.id,
              action_type_id: @action_type.id,
              identifier: params[:badge_action][:identifier]
            )
            @rewards = Reward.where(product_id: ActsAsTenant.current_tenant.id).joins(:assigned_rewards).where(assigned_rewards: {assigned_type: 'ActionType', assigned_id: @action_type.id}).order(completion_requirement: :asc)
          else
            render_422(_('Action type is invalid.'))
          end
        end
      end
    end
  end
end
