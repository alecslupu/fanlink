# frozen_string_literal: true


module Api
  module V4
    class RewardsController < Api::V3::RewardsController
      def index
        @rewards = paginate(Reward.all.order(created_at: :asc))
        return_the @rewards, handler: tpl_handler
      end

      def show
        return_the @reward, handler: tpl_handler
      end

      def create
        @reward = Reward.create(reward_params)
        if @reward.valid?
          return_the @reward, handler: tpl_handler, using: :show
        else
          render_422 @reward.errors
        end
      end

      def update
        if params.has_key?(:reward)
          if @reward.update(reward_params)
            return_the @reward, handler: tpl_handler, using: :show
          else
            render_422 @reward.errors
          end
        else
          return_the @reward, handler: tpl_handler, using: :show
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
