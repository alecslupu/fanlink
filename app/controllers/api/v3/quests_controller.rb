# frozen_string_literal: true

module Api
  module V3
    class QuestsController < Api::V2::QuestsController
      before_action :admin_only, except: %i[index show]
      load_up_the Quest, only: %i[update]
      # **
      #
      # @api {GET} /quests Get quests for a product
      # @apiName GetQuests
      # @apiGroup Quests
      # @apiVersion  2.0.0
      # @apiDescription Gets quests that haven't been soft deleted.
      #
      #
      # @apiParam  {String} [product] Product name. Uses current_user if not passed.
      #
      # @apiSuccess (200) {Object[]} quests List of quests for product
      # @apiSuccess (200) {Integer} quests.id ID of quest
      # @apiSuccess (200) {Integer} quests.product_id Product id the quest is attached to
      # @apiSuccess (200) {Integer} quests.event_id Optional event id the quest is attached to
      # @apiSuccess (200) {String} quests.name Name of the quest
      # @apiSuccess (200) {String} quests.description Description of the quest
      # @apiSuccess (200) {String} quests.picture_url The url for the attached picture
      # @apiSuccess (200) {String} quests.status The current status of the quest. Can be Active, Enabled, Disabled.
      # @apiSuccess (200) {String} quests.starts_at When the quest should be active.
      # @apiSuccess (200) {String} quests.ends_at Optional end time for when the quest should be disabled.
      # @apiSuccess (200) {Object[]} quests.activities The activities associated with the quest
      # @apiSuccess (200) {Integer} quests.activities.id ID of the activity
      # @apiSuccess (200) {String} quests.activities.description The description of the activity
      # @apiSuccess (200) {String} quests.activities.hint Hint associated with the activity
      # @apiSuccess (200) {Boolean} quests.activities.post Whether or not the activity requires a post to be created.
      # @apiSuccess (200) {Boolean} quests.activities.image Whether or not the activity requires an image to be taken.
      # @apiSuccess (200) {Boolean} quests.activities.audio Whether or not the activity requires an audio clip.
      # @apiSuccess (200) {String} quests.activities.beacon The beacon associated with the activity
      # @apiSuccess (200) {Integer} quests.activities.step The step number for quest progression
      #
      # @apiParamExample  {json} Request-Example:
      # {
      #     "product" : "admin"
      # }
      #
      #
      # @apiSuccessExample {Object[]} Success-Response:
      #   HTTP/1.1 200 OK
      # {
      #    "quests":
      #       [
      #            {
      #               "quest_id": 1,
      #               "product_id": 1,
      #               "event_id": 99,
      #               "name": "My New Quest",
      #               "description": "Find Waldy",
      #               "picture_url": "https://assets.example.com/hi.jpg",
      #               "status": "enabled",
      #               "starts_at": "2031-08-18T10:22:08Z",
      #               "ends_at": "2033-08-18T10:22:08Z",
      #               "activities": [
      #                    "activity": {
      #                        See quest_activity#index
      #                ]
      #
      #           },
      #           {
      #               "quest_id": 2,
      #               "product_id": 1,
      #               "event_id": 102,
      #               "name": "Don't get caught",
      #               "description": "Steal the Declaration of Independence",
      #               "picture": {object},
      #               "status": "enabled",
      #               "starts_at": 1776-07-04T10:22:08Z,
      #               "ends_at": 2004-11-19T10:22:08Z
      #       },
      #    ]
      # }
      # *

      def index
        @quests = paginate(Quest.includes(:rewards, steps: [:quest_activities]).where.not(status: :deleted).order(created_at: :desc))
        return_the @quests, handler: tpl_handler
      end

      # **
      #
      # @api {post} /quests Create a quest
      # @apiName CreateQuest
      # @apiGroup Quests
      # @apiVersion  2.0.0
      # @apiDescription Creates a quest for the product.
      # @apiPermission admin
      #
      # @apiParam (body) {String} [product] Product name. Uses current_user if not passed.
      # @apiParam (body) {Object} quest Quest container for form data
      # @apiParam (body) {Integer} [quest.event_id] Optional event id to attach a quest to an event
      # @apiParam (body) {String} quest.name Name of the quest
      # @apiParam (body) {String} quest.internal_name Internal name for the quest
      # @apiParam (body) {String} quest.description Desciption of the quest.
      # @apiParam (body) {Object} [quest.picture] Image attached to the quest
      # @apiParam (body) {String} [quest.status] Current quest status. Can be Active, Enabled, Disabled or Deleted
      # @apiParam (body) {String} quest.starts_at Datetime String for when the quest starts.
      # @apiParam (body) {String} [quest.ends_at] Datetime String for when the quest is over.
      #
      #
      # @apiSuccess (200) {Object} quest Quest object that was saved to the database
      # @apiSuccess (200) {Integer} quest.id ID of quest
      # @apiSuccess (200) {Integer} quest.product_id Product id the quest is attached to
      # @apiSuccess (200) {Integer} quest.event_id Optional event id the quest is attached to
      # @apiSuccess (200) {String} quest.name Name of the quest
      # @apiSuccess (200) {String} quest.description Description of the quest
      # @apiSuccess (200) {String} quest.picture_url The url for the attached picture
      # @apiSuccess (200) {String} quest.status The current status of the quest. Can be Active, Enabled, Disabled.
      # @apiSuccess (200) {String} quest.starts_at When the quest should be active.
      # @apiSuccess (200) {String} quest.ends_at Optional end time for when the quest should be disabled.
      # @apiSuccess (200) {Object[]} quest.activities The activities associated with the quest
      #
      #
      #
      # @apiSuccessExample {Object} Success-Response:
      # HTTP/1.1 200 OK
      # {
      #    "quest": {
      #         "id": "1",
      #         "product_id": "1",
      #         "event_id": "",
      #         "name": "Don't get caught",
      #         "internal_name": "national_treasure",
      #         "description": "Steal the Declaration of Independence",
      #         "picture_url": null,
      #         "status": "enabled",
      #         "starts_at": "1776-07-04T10:22:08Z",
      #         "ends_at": "2004-11-19T10:22:08Z",
      #         "create_time": "2018-04-30T23:00:20Z",
      #         "activities": null
      #     }
      # }
      #
      #
      # *

      def create
        @quest = Quest.create(quest_params)
        if @quest.valid?
          return_the @quest
        else
          render_422 @quest.errors
        end
      end

      # **
      #
      # @api {patch} /quest/:id Update a quest
      # @apiName QuestUpdate
      # @apiGroup Quests
      # @apiVersion  2.0.0
      #
      #
      # @apiParam (path) {Integer} id ID of the quest to update
      #
      # @apiParam (body) {String} [product] Product name. Uses current_user if not passed.
      # @apiParam (body) {Object} quest Quest container for form data
      # @apiParam (body) {Integer} [quest.event_id] Optional event id to attach a quest to an event
      # @apiParam (body) {String} [quest.name] Name of the quest
      # @apiParam (body) {String} [quest.internal_name] Internal name for the quest
      # @apiParam (body) {String} [quest.description] Desciption of the quest.
      # @apiParam (body) {Object} [quest.picture] Image attached to the quest
      # @apiParam (body) {String} [quest.status] Current quest status. Can be Active, Enabled, Disabled or Deleted
      # @apiParam (body) {String} [quest.starts_at] Datetime String for when the quest starts.
      # @apiParam (body) {String} [quest.ends_at] Datetime String for when the quest is over.
      #
      #
      # @apiSuccess (200) {Object} quest Quest object that was saved to the database
      # @apiSuccess (200) {Integer} quest.id ID of quest
      # @apiSuccess (200) {Integer} quest.product_id Product id the quest is attached to
      # @apiSuccess (200) {Integer} quest.event_id Optional event id the quest is attached to
      # @apiSuccess (200) {String} quest.name Name of the quest
      # @apiSuccess (200) {String} quest.description Description of the quest
      # @apiSuccess (200) {String} quest.picture_url The url for the attached picture
      # @apiSuccess (200) {String} quest.status The current status of the quest. Can be Active, Enabled, Disabled.
      # @apiSuccess (200) {String} quest.starts_at When the quest should be active.
      # @apiSuccess (200) {String} quest.ends_at Optional end time for when the quest should be disabled.
      # @apiSuccess (200) {Object[]} quest.activities The activities associated with the quest
      #
      #
      #
      # @apiSuccessExample {Object} Success-Response:
      # HTTP/1.1 200 OK
      # {
      #    "quest": {
      #         "id": "1",
      #         "product_id": "1",
      #         "event_id": "",
      #         "name": "Don't get caught",
      #         "internal_name": "national_treasure",
      #         "description": "Steal the Declaration of Independence",
      #         "picture_url": null,
      #         "status": "enabled",
      #         "starts_at": "1776-07-04T10:22:08Z",
      #         "ends_at": "2004-11-19T10:22:08Z",
      #         "create_time": "2018-04-30T23:00:20Z",
      #         "activities": null
      #     }
      # }
      #
      #
      # *

      def update
        if params.has_key?(:quest)
          if @quest.update(quest_params)
            return_the @quest
          else
            render_422 @quest.errors
          end
        else
          render_422(_('Update failed. Missing quest object.'))
        end
      end

      protected

      def tpl_handler
        :jb
      end

      private

      def quest_params
        params.require(:quest).permit(:event_id, :name, :internal_name, :description, :picture, :status, :starts_at, :ends_at,
                                      steps_attributes: [:id, :unlocks, :display, :initial_status, :delay_unlock, :uuid,
                                                         quest_activities_attributes: [:id, :description, :hint, :picture,
                                                                                       activity_types_attributes: [:id, :atype, {value: [:id, :description]}]
                                                         ]
                                      ]
        )
      end
    end
  end
end
