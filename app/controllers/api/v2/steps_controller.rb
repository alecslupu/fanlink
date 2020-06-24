# frozen_string_literal: true

module Api
  module V2
    class StepsController < ApiController
      load_up_the Quest, from: :quest_id, only: %i[create index]
      load_up_the Step, from: :id, only: %i[update delete]

      # **
      # @apiDefine Success
      #    description
      # @apiSuccess (200) {Object} Step Step container
      # @apiSuccess (200) {Integer} step.id ID of the step
      # @apiSuccess (200) {Integer} step.quest_id The ID of the quest the step is attached to
      # @apiSuccess (200) {Number[]} step.unlocks An array of ids completing this step will unlock. If the step doesn't unlock anything, returns null. Pass as {1,2,3} for multiple steps.
      # @apiSuccess (200) {String} step.display Optional display name. Returns Step {step_id} if null
      # @apiSuccess (200) {String} status Current users step status. If a user hahsn't completed any steps, it will return the initial status set in the portal
      #
      # @apiSuccessExample {Object} Success-Response:
      # HTTP/1.1 200 OK
      # {
      #     "step": {
      #         "id": "2",
      #         "quest_id": "1",
      #         "unlocks": [
      #             3,
      #             4
      #         ],
      #         "display": "Step 22",
      #         "status": "unlocked"
      #     }
      # }
      # *

      # **
      # @apiDefine Successes
      #    Array of success objects
      # @apiSuccess (200) {Object[]} Steps Steps container
      # @apiSuccess (200) {Integer} steps.id ID of the step
      # @apiSuccess (200) {Integer} steps.quest_id The ID of the quest the step is attached to
      # @apiSuccess (200) {Number[]} steps.unlocks An array of ids completing this step will unlock. If the step doesn't unlock anything, returns null. Pass as {1,2,3} for multiple steps.
      # @apiSuccess (200) {String} steps.display Optional display name. Returns Step {step_id} if null
      #
      # @apiSuccessExample {Object[]} Success-Response:
      # HTTP/1.1 200 OK
      # {
      #     "steps": [
      #         {
      #             "id": "1",
      #             "quest_id": "1",
      #             "unlocks": [
      #                 2
      #             ],
      #             "display": "Step 1",
      #             "status": "completed"
      #         },
      #         {
      #             "id": "2",
      #             "quest_id": "1",
      #             "unlocks": [
      #                 3
      #             ],
      #             "display": "Step 2",
      #             "status": "unlocked"
      #         },
      #         {
      #             "id": "3",
      #             "quest_id": "1",
      #             "unlocks": null,
      #             "display": "Step 3",
      #             "status": "locked"
      #         }
      #     ]
      # }
      # *

      # **
      #
      # @api {get} /quests/:id/steps Get Steps for a quest
      # @apiName GetSteps
      # @apiGroup Quest Steps
      # @apiVersion  1.0.0
      #
      #
      # @apiParam (path) {Integer} id ID of the quest
      #
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X GET \
      # http://localhost:3000/quests/1/steps \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      #
      #
      # @apiUse Successes
      #
      #
      # *

      def index
        @steps = @quest.steps.order(created_at: :asc)
        return_the @steps
      end

      # **
      #
      # @api {post} /quests/:quest_id/steps Create a step for a quest
      # @apiName CreateStep
      # @apiGroup Quest Steps
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} quest_id The quest id used in the url
      #
      # @apiParam (body) {Number[]} [unlocks] The steps that are unlocked when this step is completed. Pass as {1,2,3} for multiple steps.
      # @apiParam (body) {String} [display] Sets the display name for the step.
      #
      #
      # @apiParamExample  {curl} Request-Example:
      #   curl -X POST \
      #   http://localhost:3000/quests/1/steps \
      #   -H 'Accept: application/vnd.api.v2+json' \
      #   -H 'Cache-Control: no-cache' \
      #   -H 'Content-Type: application/x-www-form-urlencoded' \
      #   -d step%5Bprereq_step%5D=2
      #
      #
      # @apiUse Success
      #
      #
      # *

      def create
        @step = @quest.steps.create(step_params)
        if @step.valid?
          broadcast(:step_created, current_user, @step)
          return_the @step
        else
          render json: { errors: @step.errors.messages }, status: :unprocessable_entity
        end
      end

      # **
      #
      # @api {patch} /steps/:id Update a step
      # @apiName StepUpdate
      # @apiGroup Quest Steps
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id ID of the step to update
      #
      # @apiParam (body) {Number[]} [unlocks] The steps that are unlocked when this step is completed. Pass as {1,2,3} for multiple steps.
      # @apiParam (body) {String} [display] The display friendly name for select boxes.
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X PATCH \
      # http://localhost:3000/steps/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: application/x-www-form-urlencoded' \
      # -d 'step%5Bprereq_step%5D=1&step%5Bdisplay%5D='
      #
      #
      # @apiUse Success
      #
      #
      # *

      def update
        @step.update(step_params)
        return_the @step
      end

      # **
      #
      # @api {get} /steps/:id Get a step
      # @apiName GetQuestStep
      # @apiGroup Quest Steps
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id The ID of the step
      #
      # @apiParamExample  {curl} Request-Example:
      # TODO
      #
      # @apiUse Success
      #
      # *

      def show
        @step = Step.find(params[:id])
        return_the @step
      end

      # **
      #
      # @api {DELETE} /steps/:id Delete a step
      # @apiName DeleteQuestStep
      # @apiGroup Quest Steps
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id Step ID
      #
      # @apiSuccess (Header) {200} 200 Returns a 200
      #
      # @apiParamExample  {curl} Request-Example:
      # TODO
      #
      # @apiSuccessExample {Header} Success-Response:
      #     # HTTP/1.1 200 OK
      #
      #
      # *

      def destroy
        if some_admin?
          @step.deleted = true
          @step.save
          head :ok
        else
          render_not_found
        end
      end

      private

      def step_params
        params.require(:step).permit(:unlocks, :display, :initial_status, :delay_unlock,
                                     quest_activities_attributes: [:id, :description, :hint, :picture,
                                                                   activity_types_attributes: [:id, :atype, { value: [:id, :description] }]])
      end
    end
  end
end
