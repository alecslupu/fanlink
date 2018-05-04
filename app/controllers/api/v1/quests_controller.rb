class Api::V1::QuestsController < ApiController
    include Rails::Pagination

    before_action :admin_only, except: %i[ index show ]

    #**
    # 
    # @api {GET} /quests Get quests for a product
    # @apiName GetQuests
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Gets quests that haven't been soft deleted.
    # 
    # 
    # @apiParam  {String} [product] Product name. Uses current_user if not passed.
    # 
    # @apiSuccess (200) {Array} data List of quests for product
    # 
    # @apiParamExample  {json} Request-Example:
    # {
    #     product : admin
    # }
    # 
    # 
    # @apiSuccessExample {Array} Success-Response:
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
    #               "picture": {object},
    #               "status": "enabled",
    #               "starts_at": "2031-08-18T10:22:08Z",
    #               "ends_at": "2033-08-18T10:22:08Z",
    #               "activities": [{See Quest_Activity#show method}]
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
    #*

    def index
        @quests = paginate(Quest.where.not(status: :deleted))
        return_the @quests
    end

    #**
    # 
    # @api {get} /quests/:id Get a single quest
    # @apiName GetQuest
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Returns a single quest for a product
    # 
    # 
    # @apiParam  {Number} id ID of the activity
    # 
    # @apiSuccess (200) {Object} Quest Single quest returned from id
    # 
    # @apiParamExample  {json} Request-Example:
    # {
    #     id : 1
    # }
    # 
    # 
    # @apiSuccessExample {json} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "quest": {
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
    #*

    def show
        @quest = Quest.where.not(status: :deleted).find(params[:id])
        return_the @quest
    end

    #**
    # 
    # @api {post} /quests Create a quest
    # @apiName CreateQuest
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Creates a quest for the product.
    # @apiPermission admin
    # 
    # @apiParam  {String} [product] Product name. Uses current_user if not passed.
    # @apiParam  {Object} quest Quest container for form data
    # @apiParam  {Number} [quest.event_id] Optional event id to attach a quest to an event
    # @apiParam  {String} quest.name Name of the quest
    # @apiParam  {String} quest.internal_name Internal name for the quest
    # @apiParam  {String} quest.description Desciption of the quest.
    # @apiParam  {Object} [quest.picture] Image attached to the quest
    # @apiParam  {String} [quest.status] Current quest status. Can be Active, Enabled, Disabled or Deleted
    # @apiParam  {Datetime} quest.starts_at Datetime String for when the quest starts.
    # @apiParam  {Datetime} [quest.ends_at] Datetime String for when the quest is over.
    # 
    #
    # @apiSuccess (200) {Json} quest Quest object that was saved to the database
    # 
    # 
    # 
    # @apiSuccessExample {type} Success-Response:
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
    #*

    def create
        @quest = Quest.create(quest_params)
        return_the @quest
    end

    #**
    # 
    # @api {get} /quests/list Get a list of all quests (ADMIN ONLY)
    # @apiName GetQuestList
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Returns a list of all quests regardless of status.
    # @apiPermission admin
    # 
    # @apiParam {Integer} [page]
    #   The page number to get. Default is 1.
    #
    # @apiParam {Integer} [per_page]
    #   The pagination division. Default is 25.
    #
    # @apiParam {Integer} [product_id_filter]
    #   Full match on person id.
    #
    # @apiParam {String} [name_filter]
    #   Full or partial match on quest name.
    #
    # @apiParam {String} [internal_name_filter]
    #   Full or partial match on quest's internal name.
    #
    # @apiParam {String} [description_filter]
    #   Full or partial match on the quest description.
    #
    # @apiParam {Datetime} [starts_at_filter]
    #   Quest starts at or after timestamp. Format: "2018-01-08'T'12:13:42'Z'"
    #
    # @apiParam {Datetime} [ends_at_filter]
    #   Quest ends at or before timestamp. Format: "2018-01-08'T'12:13:42'Z'"
    #
    # @apiParam {String} [status_filter]
    #   Quest status. Valid values: active enabled disabled deleted
    #
    # @apiSuccess (200) {Object[]} quests Returns a quests object with an array of quests
    # 
    # @apiSuccessExample {200} Success-Response:
    # {
    #     Same as index. Returns soft deleted quests as well
    # }
    # 
    # 
    #*
    def list
        @quests = paginate apply_filters
        return_the @quests
    end

    #**
    # 
    # @api {delete} /quests/:id Delete Quest
    # @apiName QuestDelete
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiPermission admin, superadmin
    # 
    # 
    # @apiParam  {Number} id ID of quest to delete
    # 
    # @apiSuccess (200) {Header} ok Returns a 200 OK response
    # 
    # 
    # 
    # @apiSuccessExample {Header} Success-Response:
    # HTTP/1.1 200 OK
    # 
    # 
    #*
    def destroy
        quest = Quest.find(params[:id])
        if current_user.some_admin?
          quest.deleted!
          head :ok
        else
          render_not_found
        end    
    end

private
    def apply_filters
        quests = Quest.where.not(status: :deleted).order(created_at: :desc)
        params.each do |p, v|
            if p.end_with?("_filter") && Quest.respond_to?(p)
              quests = quests.send(p, v)
            end
        end
        quests
    end

    def quest_params
        params.require(:quest).permit(:event_id, :name, :internal_name, :description, :picture, :status, :starts_at, :ends_at, quest_activities: %i[ description hint post image audio requires ])
    end    
end