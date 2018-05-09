class Api::V1::QuestCompletionsController < ApiController
    include Rails::Pagination
    before_action :admin_only, only: %i[ list update delete ]
    load_up_the Quest, from: :quest_id, except: %i[ update ]
    load_up_the Person, from: :person_id, only: %i[ for_person ]
    load_up_the QuestActivity, from: :quest_activity_id, only: %i[ for_actvitiy ]

    #**
    # @apiDefine SuccessResponse
    #    The success response for a single completion
    # @apiSuccess (200) {Object} completion Container for the completion data
    # @apiSuccess (200) {Number} completion.id ID of the created completion
    # @apiSuccess (200) {Number} completion.person_id The ID of the user who completed the activity
    # @apiSuccess (200) {Number} completion.quest_id ID of the quest
    # @apiSuccess (200) {Number} completion.activity_id ID of the activity that was completed
    # @apiSuccess (200) {DateTime} completion.created_at The date and time the completion was created.
    #
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "completion": {
    #         "id": "1",
    #         "person_id": "1",
    #         "activity_id": "1",
    #         "create_time": "2018-05-08T23:24:48Z"
    #     }
    # }
    #
    #**

    #**
    # @apiDefine SuccessResponses
    #    Returns an array as a response
    # @apiSuccess (200) {Object} completions Container for the completion data
    # @apiSuccess (200) {Number} completions.id ID of the created completion
    # @apiSuccess (200) {Number} completions.person_id The ID of the user who completed the activity
    # @apiSuccess (200) {Number} completions.quest_id ID of the quest
    # @apiSuccess (200) {Number} completions.activity_id ID of the activity that was completed
    # @apiSuccess (200) {DateTime} completions.created_at The date and time the completion was created.
    #
    # @apiSuccessExample {Object[]} Success-Response:
    # {
    #     "completions": [
    #         {
    #             "id": "1",
    #             "person_id": "1",
    #             "activity_id": "1",
    #             "create_time": "2018-05-09T17:14:07Z"
    #         },
    #         {
    #             "id": "2",
    #             "person_id": "1",
    #             "activity_id": "2",
    #             "create_time": "2018-05-09T17:14:13Z"
    #         }
    #     ]
    # }
    #**



    #**
    # 
    # @api {get} /quests/:id/completions Get completions for quest
    # @apiName GetCompletions
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {id} id Quest ID
    # 
    # @apiUse SuccessResponse
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X GET \
    # http://192.168.1.110:3000/quests/1/completions \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    # 
    #*

    def index
        @completions = @quest.quest_completions
        return_the @completions
    end

    #**
    # 
    # @api {get} /people/:id/completions Get completions for a person
    # @apiName GetPersonCompletions
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {id} id Person ID
    # 
    # @apiUse SuccessResponse
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X GET \
    # http://api.examplecom/people/1/completions \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    # 
    #*

    def for_person
        @completions = @person.quest_completions
        return_the @completions
    end

    #**
    # 
    # @api {get} /quest_activity/:id/completions Get completions for a person
    # @apiName GetActivityCompletions
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {id} id Activity ID
    # 
    # @apiUse SuccessResponses
    # 
    # @apiParamExample  {url} Request-Example:
    # https://localhost:3000/quest_activity/1/completions
    # 
    # 
    #*

    def for_activity
        @completions = @person.quest_completions
        return_the @completions
    end

    # 
    # @api {post} /quests/:id/completions Register an activity for quest as complete
    # @apiName CreateCompletion
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # @apiHeader (200) {String} field description
    # 
    # @apiParam  {Number} quest_id The id of the quest the completion is associated with
    # @apiParam  {Number} activity_id The id of the completed activity
    # 
    # @apiUse SuccessResponse
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X GET \
    # http://localhost:3000/quest_activities/1/completions \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    #*

    def create
        @completion = QuestCompletion.create(completion_params.merge(person_id: current_user.id, quest_id: params[:quest_id]))
        puts @completion.errors.full_messages.to_sentence
        return_the @completion
    end

    #**
    # 
    # @api {get} /completions/:id Get a quest by completion id
    # @apiName GetCompletion
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # @apiParam  {Number} id ID of the completion
    # 
    # @apiUse SuccessResponse
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X GET \
    # http://localhost:3000/completions/1 \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    #*

    def show
        @completion = QuestCompletion.find(params[:id])
        return_the @completion
    end

    #**
    # 
    # @api {get} /quests/:id/completions/list Get a quest by completion id
    # @apiName GetQuestCompletionsList
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # @apiParam {Number} [page] The page number to get. Default is 1.
    #
    # @apiParam {Number} [per_page] The pagination division. Default is 25.
    #
    # @apiParam {Number} [person_id_filter] Full match on person id.
    # @apiParam {String} [person_filter] Full match name or email of person.
    # @apiParam {Number} [quest_id_filter] Full match on quest id.
    # @apiParam {String} [quest_filter] Full match name of quest.
    # @apiParam {Number} [activity_id_filter] Full match on activity id.
    # @apiParam {String} [activity_filter] Full match name of activity.
    # 
    # @apiParamExample  {curl} Request-Example:
    # curl -X GET \
    # 'http://localhost:3000/completions/list?person__id_filter=1' \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache'
    # 
    # 
    # @apiUse SuccessResponses
    # 
    # 
    #*

    def list
        @completions = paginate apply_filters
        return_the @completions
    end

    #**
    # 
    # @api {patch} /completion/:id Update a tracked completion
    # @apiName CompletionUpdate
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the completion being updated
    # @apiParam  {Number} [activity_id] The id of the completed activity
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
    # @apiUse SuccessResponse
    # 
    # 
    #*
    def update
        @completion.update_attributes(completion_params)
        return_the @completion
    end

    #**
    # @apiIgnore Not used currently
    # @api {delete} /completion/:id Soft delete a completion
    # @apiName CompletionDelete
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the completion that is being deleted
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
    #*

    # def destroy
    #     quest_completion = QuestCompletion.find(params[:id])
    #     if current_user.some_admin?
    #       quest_completion.deleted!
    #       head :ok
    #     else
    #       render_not_found
    #     end  
    # end

private
    def completion_params
        params.require(:quest_completion).permit(:activity_id)
    end

    def apply_filters
        completions = QuestCompletion.order(created_at: :desc)
        params.each do |p, v|
            if p.end_with?("_filter") && QuestCompletion.respond_to?(p)
              completions = completions.send(p, v)
            end
        end
        completions
    end

end
  