# frozen_string_literal: true


module Api
  module V3
    class QuestActivitiesController < Api::V2::QuestActivitiesController
      before_action :admin_only, except: %i[index show]
      load_up_the Step, from: :step_id, except: %i[update show delete]
      load_up_the QuestActivity, only: %i[update show delete]

      # **
      # @apiDefine Success
      #    Success Object
      #
      # @apiSuccess (200) {Object} quest_activity Returns the updated quest activity
      #
      # @apiSuccessExample {Object} Success-Response:
      # {
      #     "activity": {
      #         "id": "1",
      #         "quest_id": "1",
      #         "step_id": 1,
      #         "description": "Escape to Boston",
      #         "hint": "Find the glasses",
      #         "picture_url": null,
      #         "picture_width": null,
      #         "picture_height": null,
      #         "completed": false,
      #         "requirements": [
      #             {
      #                 "id": 1,
      #                 "activity_id": 1,
      #                 "type": "beacon",
      #                 "value": {
      #                     "id": "1",
      #                     "product_id": "1",
      #                     "beacon_pid": "A12FC4-12912",
      #                     "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
      #                     "lower": "25",
      #                     "upper": "75",
      #                     "created_at": "2018-05-18T12:53:35.949Z"
      #                 }
      #             },
      #             {
      #                 "id": 2,
      #                 "activity_id": 1,
      #                 "type": "activity_code",
      #                 "value": {
      #                     "id": "14245154"
      #                 }
      #             }
      #         ],
      #         "deleted": false,
      #         "step": {
      #             "id": "1",
      #             "quest_id": "1",
      #             "unlocks": null,
      #             "display": "Step 1",
      #             "status": "unlocked"
      #         },
      #         "created_at": "2018-05-18T12:59:09.734Z"
      #     }
      # }
      # *

      # **
      # @apiDefine Successes
      #    Success Array
      #
      # @apiSuccess (200) {Object[]} quest_activities An array of activity objects
      #
      # @apiSuccessExample {Object[]} Success-Response:
      # HTTP/1.1 200 OK
      # {
      #     "activities": [
      #         {
      #             "id": "1",
      #             "quest_id": "1",
      #             "step_id": 1,
      #             "description": "Escape to Boston",
      #             "hint": "Find the glasses",
      #             "picture_url": null,
      #             "picture_width": null,
      #             "picture_height": null,
      #             "completed": false,
      #             "requirements": [
      #                 {
      #                     "id": 1,
      #                     "activity_id": 1,
      #                     "type": "beacon",
      #                     "value": {
      #                         "id": "1",
      #                         "product_id": "1",
      #                         "beacon_pid": "A12FC4-12912",
      #                         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
      #                         "lower": "25",
      #                         "upper": "75",
      #                         "created_at": "2018-05-18T12:53:35.949Z"
      #                     }
      #                 },
      #                 {
      #                     "id": 2,
      #                     "activity_id": 1,
      #                     "type": "activity_code",
      #                     "value": {
      #                         "id": "14245154"
      #                     }
      #                 }
      #             ],
      #             "activity_code": "2451313213",
      #             "deleted": false,
      #             "step": {
      #                 "id": "1",
      #                 "quest_id": "1",
      #                 "unlocks": null,
      #                 "display": "Step 1",
      #                 "status": "unlocked"
      #             },
      #             "created_at": "2018-05-18T12:59:09.734Z"
      #         }
      #     ]
      # }
      # *

      # **
      #
      # @api {post} /steps/:id/activities Create an activity for a step
      # @apiName CreateQuestActivity
      # @apiGroup Quest Activities
      # @apiVersion  2.0.0
      # @apiDescription Create a quest activity
      # @apiPermission admin
      #
      #
      # @apiParam (path) {number} id Quest ID
      # @apiParam (body) {Object} activity Container for the quest activity fields
      # @apiParam (body) {String} description A description of the requirements for the activity
      # @apiParam (body) {String} [hint] Optional hint text
      # @apiParamExample  {curl} Request-Example:
      # curl -X POST \
      # http://localhost:3000/quests/1/activities \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Accept-Language: en' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: multipart/form-data' \
      # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
      # -F 'quest_activity[description]=Escape to Boston' \
      # -F 'quest_activity[hint]=Find the glasses' \
      # -F 'quest_activity[picture]=undefined'
      #
      # @apiUse Success
      #
      #
      # *
      def create
        @quest_activity = @step.quest_activities.create(activity_params)
        if @quest_activity.valid?
          return_the @quest_activity
        else
          render_422 @quest_activity.errors
        end
      end

      # **
      #
      # @api {patch} /activities/:id Update a quest activity
      # @apiName QuestActivityUpdate
      # @apiGroup Quest Activities
      # @apiVersion  2.0.0
      # @apiDescription Update a quest activity with optional fields
      # @apiPermission admin
      #
      #
      # @apiParam (path) {Integer} id ID of activity to update
      # @apiParam (body) {Object} activity Container for the quest activity fields
      # @apiParam (body) {String} [description] A description of the requirements for the activity
      # @apiParam (body) {String} [hint] Optional hint text
      #
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X PATCH \
      # http://localhost:3000/activities/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
      #
      # @apiUse Success
      #
      #
      # *

      def update
        if params.has_key?(:quest_activity)
          if @quest_activity.update(activity_params)
            return_the @quest_activity
          else
            render_422 @message.errors
          end
        else
          render_422(_('Updated failed. Missing quest_activity object.'))
        end
      end

      # **
      #
      # @api {get} /quests/:id/activities Get Quest Activities
      # @apiName GetQuestActivities
      # @apiGroup Quest Activities
      # @apiVersion  2.0.0
      # @apiDescription Retrieve all activities for a given quest
      # @apiPermission user
      #
      #
      # @apiParam (path) {Integer} id Quest ID
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X GET \
      # http://localhost:3000/quests/1/activities \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      #
      # @apiUse Successes
      #
      #
      # *

      def index
        @quest_activities = @step.quest_activities.with_completion(current_user).order(created_at: :desc)
        return_the @quest_activities
      end

      # **
      #
      # @api {get} /activities/:id Get a quest activity
      # @apiName GetQuestActivity
      # @apiGroup Quest Activities
      # @apiVersion  2.0.0
      # @apiDescription Retrieve a single quest activity from the database
      # @apiPermission user
      #
      #
      # @apiParam (path) {Integer} id Activity ID
      #
      # @apiParamExample  {Url} Request-Example:
      # curl -X GET \
      # http://localhost:3000/activities/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      #
      # @apiUse Success
      #
      #
      # *

      def show
        @quest_activity = QuestActivity.find(params[:id])
        return_the @quest_activity
      end

      # **
      #
      # @api {delete} /activities/:id Destroy a quest activity
      # @apiName QuestActivityDestroy
      # @apiGroup Quest Activities
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id Activity id
      #
      # @apiSuccess (200) {Header} header 200 OK header response
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X DELETE \
      # http://localhost:3000/activities/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      # @apiSuccessExample {Header} Success-Response:
      # HTTP/1.1 200 OK
      #
      #
      # *

      def destroy
        if some_admin?
          if @quest_activity.update(deleted: true)
            head :ok
          else
            render_422(_('Failed to delete the quest activity.'))
          end
        else
          render_not_found
        end
      end

      private

      def activity_params
        params.require(:quest_activity).permit(:description, :hint, :picture, :title,
                                               activity_types_attributes: [:id, :atype, {value: [:id, :description]}]
        )
      end
    end
  end
end
