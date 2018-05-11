class Api::V1::QuestActivitiesController < ApiController
    before_action :admin_only, except: %i[ index show ]
    load_up_the Quest, from: :quest_id, except: %i[ update show delete ]
    load_up_the QuestActivity, only: %i[ update show ]

    #**
    # 
    # @api {post} /quests/:id/activities Create quest activity
    # @apiName CreateQuestActivity
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Create a quest activity
    # @apiPermission admin
    # 
    # 
    # @apiParam  {number} id Quest ID
    # @apiParam  {Object} quest_activity Container for the quest activity fields
    # @apiParam  {String} description A description of the requirements for the activity
    # @apiParam  {String} [hint] Optional hint text
    # @apiParam  {Boolean} [post] Boolean for whether or not the activity requires a post
    # @apiParam  {Boolean} [image] Boolean for whether or not the activity requires an image to be attached
    # @apiParam  {Boolean} [audio] Boolean for whether or not the activity requires an audio file
    # @apiParam  {String} beacon Beacon attached to the activity
    # @apiParam  {Number} [actvity_code] The code required to enable the activity
    # @apiParam  {Number} step Used to order the activities. Multiple activities can share the same step
    # 
    # @apiSuccess (200) {json} quest_activity Returns the create quest activity
    # 
    # curl -X POST \
    # http://localhost:3000/quests/1/activities \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Accept-Language: en' \
    # -H 'Cache-Control: no-cache' \
    # -H 'Content-Type: multipart/form-data' \
    # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    # -F 'quest_activity[description]=Escape to Boston' \
    # -F 'quest_activity[hint]=Find the glasses' \
    # -F 'quest_activity[beacon]=123456-7890' \
    # -F 'quest_activity[activity_code]=293812' \
    # -F 'quest_activity[step]=0' \
    # -F 'quest_activity[picture]=undefined'
    # 
    # 
    # @apiSuccessExample {Object} Success-Response:
    # {
    #   "activity": {
    #     "id": "1",
    #     "quest_id": "1",
    #     "description": "Break into the museum",
    #     "hint": "Don't get caught",
    #     "picture_url": "https://example.com/hi.jpg",
    #     "picture_width": 1920,
    #     "picture_height": 1080,
    #     "post": false,
    #     "image": false,
    #     "audio": false,
    #     "beacon": "123456-7890",
    #     "activity_code": "983213",
    #     "step": 0
    #   }
    # }
    # 
    # 
    #*

    def create
        @quest_activity = @quest.quest_activities.create(activity_params)
        return_the @quest_activity
    end

    #**
    # 
    # @api {patch} /activities/:id Update a quest activity
    # @apiName QuestActivityUpdate
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Update a quest activity with optional fields
    # @apiPermission admin
    # 
    # 
    # @apiParam  {Number} id ID of activity to update
    # @apiParam  {Object} quest_activity Container for the quest activity fields
    # @apiParam  {String} [description] A description of the requirements for the activity
    # @apiParam  {String} [hint] Optional hint text
    # @apiParam  {Boolean} [post] Boolean for whether or not the activity requires a post
    # @apiParam  {Boolean} [image] Boolean for whether or not the activity requires an image to be attached
    # @apiParam  {Boolean} [audio] Boolean for whether or not the activity requires an audio file
    # @apiParam  {String} beacon Beacon attached to the activity
    # @apiParam  {int} step Used to order the activities. Multiple activities can share the same step
    # 
    # @apiSuccess (200) {Object} quest_activity Returns the updated quest activity
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X PATCH \
    # http://localhost:3000/activities/1 \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache' \
    # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    # -F 'quest_activity[beacon]=09876-54321'
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "activity": {
    #         "id": "1",
    #         "quest_id": "1",
    #         "description": "Break into the museum",
    #         "hint": "Got Caught! Again!",
    #         "picture_url": "https://example.com/hi.jpg",
    #         "picture_width": 1920,
    #         "picture_height": 1080,
    #         "post": false,
    #         "image": false,
    #         "audio": false,
    #         "beacon": "09876-54321",
    #         "activity_code": "23813921"
    #         "step": 0
    #     }
    # }
    # 
    # 
    #*

    def update
        @quest_activity.update_attributes(activity_params)
        return_the @quest_activity
    end

    #**
    # 
    # @api {get} /quests/:id/activities Get Quest Activities
    # @apiName GetQuestActivities
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Retrieve all activities for a given quest
    # @apiPermission user
    # 
    # 
    # @apiParam  {Number} id Quest ID
    # 
    # @apiSuccess (200) {Object[]} quest_activities An array of activity objects
    # 
    # @apiParamExample  {curl} Request-Example:
    #curl -X GET \
    # http://localhost:3000/quests/1/activities \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    #
    # @apiSuccessExample {Object[]} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "activities": [
    #         {
    #             "id": "1",
    #             "quest_id": "1",
    #             "description": "Break into the museum",
    #             "hint": "Got Caught! Again!",
    #             "picture_url": "https://example.com/hi.jpg",
    #             "picture_width": 1920,
    #             "picture_height": 1080,
    #             "post": false,
    #             "image": false,
    #             "audio": false,
    #             "beacon": "123456-7890",
    #             "activity_code": "23813921"
    #             "step": 0
    #         }
    #     ]
    # }
    # 
    # 
    #*

    def index
        @quest_activities = @quest.quest_activities.all
        return_the @quest_activities
    end

    #**
    # 
    # @api {get} /activities/:id Get a quest activity
    # @apiName GetQuestActivity
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiDescription Retrieve a single quest activity from the database
    # @apiPermission user
    # 
    # 
    # @apiParam  {Number} id Activity ID
    # 
    # @apiSuccess (200) {Object} activity Activity Object   
    # 
    # @apiParamExample  {Url} Request-Example:
    # curl -X GET \
    # http://localhost:3000/activities/1 \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
     # {
    #     "activity": {
    #         "id": "1",
    #         "quest_id": "1",
    #         "description": "Break into the museum",
    #         "hint": "Don't get caught",
    #         "picture_url": "https://example.com/hi.jpg",
    #         "picture_width": 1920,
    #         "picture_height": 1080,
    #         "post": false,
    #         "image": false,
    #         "audio": false,
    #         "beacon": "123456-7890",
    #         "activity_code": "23813921"
    #         "step": 0
    #     }
    # }
    # 
    # 
    #*

    def show
        @quest_activity = QuestActivity.find(params[:id])
        return_the @quest_activity
    end

    #**
    # 
    # @api {delete} /activities/:id Destroy a quest activity
    # @apiName QuestActivityDestroy
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {Number} id Activity id
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
    #*

    def destroy
        quest_activity = QuestActivity.find(params[:id])
        if current_user.some_admin?
            quest_activity.deleted = true
            head :ok
        else
          render_not_found
        end    
    end

private
    def activity_params
        params.require(:quest_activity).permit( :description, :hint, :post, :image, :audio, :beacon, :activity_code, :step, :picture)
    end
end