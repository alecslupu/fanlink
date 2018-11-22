class Api::V4::StepsController < Api::V3::StepsController
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
    return_the @steps, handler: 'jb'
  end

  def show
    @step = Step.find(params[:id])
    return_the @step, handler: 'jb'
  end

  def create
    @step = @quest.steps.create(step_params)
    if @step.valid?
      broadcast(:step_created, current_user, @step)
      return_the @step, handler: 'jb', using: :show
    else
      render_422 @step.errors
    end
  end

  def update
    if params.has_key?(:step)
      old_unlocks = @step.unlocks
      if @step.update_attributes(step_params)
        if old_unlocks != params[:step][:unlocks]
          broadcast(:unlocks_updated, current_user, @step)
        end
        return_the @step, handler: 'jb', using: :show
      else
        render_422 @step.errors
      end
    else
      return_the @step
    end
  end
end
