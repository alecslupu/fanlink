# frozen_string_literal: true

module Api
  module V4
    class RewardProgressesController < Api::V3::RewardProgressesController
      def create
        if params.has_key?(:reward_complete)
          controller = request.fullpath.remove('/').remove('complete').singularize
          @progress = current_user.reward_progresses
                                  .where(reward_id: params[:reward_complete][:reward_id])
                                  .first_or_initialize
          if @progress.persisted?
            return_the @progress, handler: tpl_handler
          else
            if controller == 'action_type'
              action_type = @progress.reward.action_types.first
              @progress.series = action_type.internal_name
              @series_total = current_user.reward_progresses.where(series: action_type.internal_name).sum(:total) || nil
            else
              @progress.series = @progress.reward.series || nil
            end
            @progress.actions[controller] ||= 0
            @progress.actions[controller] += 1
            @progress.total ||= 0
            @progress.total += 1
            if @progress.save
              @series_total ||= current_user.reward_progresses.where(series: @progress.series).sum(:total)
              broadcast(:reward_progress_created, current_user, @progress, @series_total)
              return_the @progress, handler: tpl_handler
            else
              render_422 @progress.errors
            end
          end
        else
          render_422 _('Missing reward_id parameter.')
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
