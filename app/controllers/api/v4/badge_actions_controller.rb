# frozen_string_literal: true

module Api
  module V4
    class BadgeActionsController < Api::V3::BadgeActionsController
      def create
        if @rewards.any?
          @rewards.each do |reward|
            if @action_type.seconds_lag > 0 && current_user.reward_progresses.where(reward_id: reward.id).where('updated_at > ?', Time.zone.now - @action_type.seconds_lag.seconds).exists?
              head :too_many_requests
              break
            else
              next if PersonReward.exists?(person_id: current_user.id, reward_id: reward.id)
              badge_action = current_user.badge_actions.new(action_type: @action_type, identifier: params[:badge_action][:identifier])
              if badge_action.save
                @progress = RewardProgress.find_or_initialize_by(reward_id: reward.id, person_id: current_user.id)
                @progress.series = @action_type.internal_name || nil
                @progress.actions['badge_action'] ||= 0
                @progress.actions['badge_action'] += 1
                @progress.total ||= 0
                @progress.total += 1
                if @progress.present? && @progress.save
                  @series_total = RewardProgress.where(person_id: current_user.id, series: @action_type.internal_name).sum(:total) || @progress.total
                  broadcast(:reward_progress_created, current_user, @progress, @series_total)
                  return_the @progress, handler: tpl_handler
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
        else
          render json: {errors: {base: _('Reward does not exist for that action type.')}}, status: :not_found
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
