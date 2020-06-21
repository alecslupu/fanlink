# frozen_string_literal: true


module Api
  module V4
    class BadgesController < Api::V3::BadgesController
      def index
        @badges = paginate(Badge.includes(reward: :assigned_rewards))
        if params.has_key?(:person_id)
          @badges_awarded = PersonReward.where(person_id: params[:person_id]).order(ordering_params(params)).joins(:reward).where('rewards.reward_type =?', Reward.reward_types['badge'])
        else
          @badges_awarded = PersonReward.where(person_id: current_user.id).order(ordering_params(params)).joins(:reward).where('rewards.reward_type =?', Reward.reward_types['badge'])
        end
        return_the @badges, handler: tpl_handler
      end

      def create
        @badge = Badge.create(badge_params)
        return_the @badge, handler: tpl_handler, using: :show
      end

      def update
        if params.has_key?(:badge)
          @badge.update(badge_params)
        end
        return_the @badge, handler: tpl_handler, using: :show
      end

      def show
        return_the @badge, handler: tpl_handler
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
