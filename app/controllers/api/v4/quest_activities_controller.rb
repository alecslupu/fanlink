# frozen_string_literal: true


module Api
  module V4
    class QuestActivitiesController < Api::V3::QuestActivitiesController
      # def index
      #   @quest_activities = @step.quest_activities.with_completion(current_user).order(created_at: :desc)
      #   return_the @quest_activities, handler: 'jb'
      # end

      # def show
      #   @quest_activity = QuestActivity.find(params[:id])
      #   return_the @quest_activity, handler: 'jb'
      # end

      # def create
      #   @quest_activity = @step.quest_activities.create(activity_params)
      #   if @quest_activity.valid?
      #     return_the @quest_activity, handler: 'jb', using: :show
      #   else
      #     render_422 @quest_activity.errors
      #   end
      # end

      # def update
      #   if params.has_key?(:quest_activity)
      #     if @quest_activity.update(activity_params)
      #       return_the @quest_activity, handler: 'jb', using: :show
      #     else
      #       render_422 @message.errors
      #     end
      #   else
      #     render_422(_("Updated failed. Missing quest_activity object."))
      #   end
      # end
    end
  end
end
