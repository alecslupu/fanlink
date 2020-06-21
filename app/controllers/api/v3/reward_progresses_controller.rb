# frozen_string_literal: true


module Api
  module V3
    class RewardProgressesController < ApiController
      def create
        if params.has_key?(:reward_complete)
          controller = request.fullpath.remove('/').remove('complete').singularize
          @progress = RewardProgress.find_or_initialize_by(reward_id: params[:reward_complete][:reward_id], person_id: current_user.id)
          if PersonReward.exists?(person_id: current_user.id, reward_id: params[:reward_complete][:reward_id])
            return_the @progress
          else
            if controller == 'action_type'
              action_type = @progress.reward.action_types.first
              @progress.series = action_type.internal_name
              @series_total = RewardProgress.where(person_id: current_user.id, series: action_type.internal_name).sum(:total) || nil
            else
              @progress.series = @progress.reward.series || nil
            end
            @progress.actions[controller] ||= 0
            @progress.actions[controller] += 1
            @progress.total ||= 0
            @progress.total += 1
            if @progress.save
              @series_total ||= RewardProgress.where(person_id: current_user.id, series: @progress.series).sum(:total)
              broadcast(:reward_progress_created, current_user, @progress, @series_total)
              return_the @progress
            else
              render_422 @progress.errors
            end
          end
        else
          render_422 _('Missing reward_id parameter.')
        end
      end


      private

      def reward_progress_params
        params.require(:reward_complete).permit(:reward_id)
      end
    end
  end
end
