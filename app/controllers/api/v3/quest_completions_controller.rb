# frozen_string_literal: true


module Api
  module V3
    class QuestCompletionsController < Api::V2::QuestCompletionsController
      before_action :admin_only, only: %i[list update delete]
      before_action :load_person, only: %i[for_person for_activity for_quest index]
      load_up_the Step, from: :step_id, only: %i[create list]


      # **
      #
      # @api {post} /steps/:id/completions Register an activity for quest as complete
      # @apiName CreateCompletion
      # @apiGroup Quest Activity Completion
      # @apiVersion  2.0.0
      # @apiHeader (200) {String} field description
      #
      # @apiParam (path) {Integer} quest_id The id of the quest the completion is associated with
      # @apiParam (body) {Integer} activity_id The id of the completed activity
      #
      # @apiUse SuccessObject
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X GET \
      # http://localhost:3000/quest_activities/1/completions \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      #
      # *


      def create
        if !params.has_key?(:step_id)
          quest_activity = QuestActivity.find(params[:activity_id])
          step_id = quest_activity.step.id
        end

        step_id ||= params[:step_id]

        @completion = QuestCompletion.create(completion_params.merge(person_id: current_user.id, step_id: step_id))

        if @completion.valid?
          broadcast(:completion_created, current_user, @completion)
          return_the @completion
        else
          render_422 @completion.errors
        end
      end

      # **
      #
      # @api {patch} /completions/:id Update a tracked completion
      # @apiName CompletionUpdate
      # @apiGroup Quest Activity Completion
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id ID of the completion being updated
      # @apiParam (body) {Integer} activity_id The id of the completed activity
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X PATCH \
      # http://localhost:3000/completions/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: application/json' \
      # -d '{
      #     "quest_completion": {
      #         "activity_id": 2
      #     }
      # }'
      #
      #
      # @apiUse SuccessObject
      #
      #
      # *
      def update
        if params.has_key?(:quest_completion)
          if @completion.update(completion_params)
            return_the @completion
          else
            render_422 @completion.errors
          end
        else
          return_the @completion
        end
      end

      # **
      # @apiIgnore Not used currently
      # @api {delete} /completions/:id Soft delete a completion
      # @apiName CompletionDelete
      # @apiGroup QuestActivityCompletion
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id ID of the completion that is being deleted
      #
      # @apiSuccess (200) {Header} OK Returns a 200 OK status if successful
      #
      # @apiParamExample  {type} Request-Example:
      # {
      #     property : value
      # }
      #
      #
      # @apiSuccessExample {Header} Success-Response:
      # HTTP/1.1 200 OK
      #
      #
      # *

      def destroy
        quest_completion = QuestCompletion.find(params[:id])
        if some_admin?
          if quest_completion.update(deleted: true)
            head :ok
          else
            render_422(_('Failed to delete the quest completion.'))
          end
        else
          render_not_found
        end
      end

      private

      def completion_params
        params.require(:quest_completion).permit(:activity_id, :status)
      end

      def load_person
        @person = Person.find(current_user.id)
      end

      def apply_filters
        completions = QuestCompletion.order(created_at: :desc)
        params.each do |p, v|
          if p.end_with?('_filter') && QuestCompletion.respond_to?(p)
            completions = completions.send(p, v)
          end
        end
        completions
      end

      def apply_filters_for_user
        completions = QuestCompletion.where(person_id: current_user.id).order(created_at: :desc)
        params.each do |p, v|
          if p.end_with?('_filter') && QuestCompletion.respond_to?(p)
            completions = completions.send(p, v)
          end
        end
        completions
      end
    end
  end
end
