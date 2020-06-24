# frozen_string_literal: true

module Api
  module V3
    class RewardsController < ApiController
      load_up_the Reward, from: :id, only: %i[show update delete]

      def index
        @rewards = paginate(Reward.all.order(created_at: :asc))
        return_the @rewards
      end

      def show
        return_the @reward
      end

      def create
        @reward = Reward.create(reward_params)
        if @reward.valid?
          return_the @reward
        else
          render_422 @reward.errors
        end
      end

      def update
        if params.has_key?(:reward)
          if @reward.update(reward_params)
            return_the @reward
          else
            render_422 @reward.errors
          end
        else
          render_422(_('Update failed. Missing the reward object.'))
        end
      end

      def destroy
        reward = Reward.find(params[:id])
        if some_admin?
          if reward.update(deleted: true)
            head :ok
          else
            render_422(_('Failed to delete the reward.'))
          end
        else
          render_not_found
        end
      end

      private

      def reward_params
        params.require(:reward).permit(:name, :internal_name, :reward_type, :reward_type_id, :series, :completion_requirement, :points, :status)
      end
    end
  end
end
