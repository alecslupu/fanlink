# frozen_string_literal: true

module Api
  module V2
    class ActivityTypesController < ApiController
      load_up_the QuestActivity, from: :activity_id, only: %i[create index]
      load_up_the ActivityType, only: %i[show update destroy]
      # **
      # @apiDefine Success
      #    Single record success response
      # @apiSuccess (200) {Object} type Container for activity type
      # @apiSuccess (200) {Number} type.id ID of the activity type
      # @apiSuccess (200) {Number} type.activity_id The ID the type is associated with
      # @apiSuccess (200) {String} type.atype The action type. Current supports beacon, post, image, audio, and access
      # @apiSuccess (200) {JSOM} type.value Json objected. Current returns id or description. Can be expanded if requested
      #
      # @apiSuccessExample {Object} Success-Response:
      # {
      #     "type": {
      #         "id": 7,
      #         "activity_id": 1,
      #         "type": "beacon",
      #         "value": {
      #             "id": "1",
      #             "product_id": "1",
      #             "beacon_pid": "A12FC4-12912",
      #             "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
      #             "lower": "25",
      #             "upper": "75",
      #             "created_at": "2018-05-18T12:28:59.542Z"
      #         }
      #     }
      # }
      # *

      # **
      # @apiDefine Successess
      #    Array of types for an activity
      #
      # @apiSuccess (200) {Object[]} types Container for activity type
      # @apiSuccess (200) {Number} types.id ID of the activity type
      # @apiSuccess (200) {Number} types.activity_id The ID the type is associated with
      # @apiSuccess (200) {String} types.atype The action type. Current supports beacon, post, image, audio, and access
      # @apiSuccess (200) {JSOM} types.value Json objected. Current returns id or description. Can be expanded if requested
      #
      # @apiSuccessExample {Object[]} Success-Response:
      # {
      #     "types": [
      #         {
      #             "id": 1,
      #             "activity_id": 1,
      #             "type": "beacon",
      #             "value": {
      #                 "id": "1",
      #                 "product_id": "1",
      #                 "beacon_pid": "A12FC4-12912",
      #                 "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
      #                 "lower": "25",
      #                 "upper": "75",
      #                 "created_at": "2018-05-18T12:53:35.949Z"
      #             }
      #         },
      #         {
      #             "id": 2,
      #             "activity_id": 1,
      #             "type": "activity_code",
      #             "value": {
      #                 "id": "14245154"
      #             }
      #         }
      #     ]
      # }
      # *

      # **
      #
      # @api {post} /activities/:id/types Create Type for Activity
      # @apiName CreateActivityType
      # @apiGroup Quest Activity Type
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Number} id Activity ID
      # @apiParam (body) {Object} activity_type Container for the form data
      # @apiParam (body) {String} activity_type.atype Activity Type. Valid types are beacon, post, image, audio, activity_code
      # @apiParam (body) {Object} activity_type.value Object for type values. Currently supports id and description
      #
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X POST \
      # http://localhost:3000/activities/1/types \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: application/x-www-form-urlencoded' \
      # -d 'activity_type%5Batype%5D=beacon&activity_type%5Bvalue%5D%5Bid%5D=1'
      #
      #
      # @apiUse Success
      #
      #
      # *

      def create
        @activity_type = @quest_activity.activity_types.create(type_params)
        if @activity_type.valid?
          return_the @activity_type
        else
          render_errors(@activity_type.errors)
        end
      end

      # **
      #
      # @api {get} /activities/:id/types Get Activities' types
      # @apiName GetActivityType
      # @apiGroup Quest Activity Type
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Number} id Activity type ID
      #
      #
      # @apiParamExample  {curl} Request-Example:
      #   curl -X GET \
      #   http://localhost:3000/activities/1/types \
      #   -H 'Accept: application/vnd.api.v2+json' \
      #   -H 'Cache-Control: no-cache'
      #
      # @apiUse Successess
      #
      # *

      def index
        @activity_types = @quest_activity.activity_types.order(created_at: :desc)
        return_the @activity_types
      end

      # **
      #
      # @api {PATCH} /activity_types/:id Update a type
      # @apiName UpdateActivityType
      # @apiGroup Quest Activity Type
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path)  {Number} id Activity type ID
      # @apiParam (body) {Object} activity_type Container for the form data
      # @apiParam (body)  {String} [activity_type.atype] Activity Type. Valid types are beacon, post, image, audio, activity_code
      # @apiParam (body)  {Object} [activity_type.value] Object for type values. Currently supports id and description. Pass entire object to update.
      #
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X PATCH \
      # http://localhost:3000/activities/1/types \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: application/x-www-form-urlencoded' \
      # -d 'activity_type%5Batype%5D=beacon&activity_type%5Bvalue%5D%5Bid%5D=1'
      #
      #
      # @apiUse Success
      #
      #
      # *

      def update
        @activity_type.update(type_params)
        return_the @activity_type
      end

      # **
      #
      # @api {get} /activity_types/:id Get a type
      # @apiName GetActivityType
      # @apiGroup Quest Activity Type
      # @apiVersion  2.0.0
      #
      #
      # @apiParam  {Number} id The ID of the activity type
      #
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X PATCH \
      # http://localhost:3000/activity_types/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache' \
      # -H 'Content-Type: application/x-www-form-urlencoded' \
      # -d 'activity_type%5Batype%5D=activity_code&activity_type%5Bvalue%5D%5Bid%5D=2313-4231A'
      #
      #
      # @apiUse Success
      #
      #
      # *

      def show
        return_the @activity_type
      end

      # **
      #
      # @api {delete} /activity_types/:id Delete a type from an activity
      # @apiName DeleteActivityType
      # @apiGroup Quest Activity Type
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Number} id Activity type ID
      #
      # @apiSuccess (200) {Header} OK 200 OK response
      #
      # @apiParamExample  {curl} Request-Example:
      # curl -X DELETE \
      # http://localhost:3000/activity_types/1 \
      # -H 'Accept: application/vnd.api.v2+json' \
      # -H 'Cache-Control: no-cache'
      #
      #
      # @apiSuccessExample {Header} Success-Response:
      # HTTP/1.1 200 OK
      #
      # *

      def destroy
        if some_admin?
          @activity_type.deleted = true
          @activity_type.save
          head :ok
        else
          render_not_found
        end
      end

      private

      def type_params
        params.require(:activity_type).permit(:atype, value: [:id, :description])
      end
    end
  end
end
