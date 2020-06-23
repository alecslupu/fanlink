# frozen_string_literal: true

module Api
  module V3
    class AssignedRewardsController < ApiController
      def index
        @assignees = paginate(AssignedReward.where(reward_id: params[:reward_id]).order(created_at: :asc))
        return_the @assignees
      end

      def show
        @assigned = AssignedReward.find(params[:id])
        return_the @assigned
      end

      def create
        if params[:assign][:assigned_type] == 'ActionType'
          action_type = ActionType.find(params[:assign][:assigned_id])
          reward = Reward.find(params[:assign][:reward_id])
          reward.series = action_type.internal_name if reward.series.blank?
          reward.save
        end
        @assigned = AssignedReward.create(assigned_reward_params)
        if @assigned.valid?
          broadcast(:assigned_reward_created, current_user, @assigned)
          return_the @assigned
        else
          render_422 @assigned.errors
        end
      end

      def update
        @assigned = AssignedReward.find(params[:id])
        if params.has_key?(:assign)
          if @assigned.update(assigned_reward_update_params)
            broadcast(:assigned_reward_updated, current_user, @assigned)
            return_the @assigned
          else
            render_422 @assigned.errors
          end
        else
          render_422(_('Updated failed. Missing assign object.'))
        end
      end

      def destroy
        if some_admin?
          @assigned = AssignedReward.find(params[:id])
          if @assigned.update(deleted: true)
            head :ok
          else
            render_422(_('Failed to delete the assigned reward.'))
          end
        else
          render_not_found
        end
      end

      private

      def assigned_reward_params
        params.require(:assign).permit(:reward_id, :assigned_type, :assigned_id, :max_times)
      end

      def assigned_reward_update_params
        params.require(:assign).permit(:max_times)
      end

      def load_assigned
        resource, id = request.path.split('/')[1, 2]
        @assigned = resource.singularize.classify.constantize.find(id)
      end
    end
  end
end
