class Api::V1::QuestCompletionController < ApiController
    before_action :admin_only, only: %i[ list update delete ]
    include Rails::Pagination
    load_up_the QuestCompletion, only: %i[ update ]
    
    #**
    # 
    # @api {post} /quest_completion Register a quest as complete
    # @apiName CreateCompletion
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # @apiParam  {Number} quest_id The id of the quest the completion is associated with
    # @apiParam  {Number} activity_id The id of the completed activity
    # 
    # @apiSuccess (200) {Object} completion Container for the completion data
    # @apiSuccess (200) {Number} completion.id ID of the created completion
    # @apiSuccess (200) {Number} completion.person_id The ID of the user who completed the activity
    # @apiSuccess (200) {Number} completion.quest_id ID of the quest
    # @apiSuccess (200) {Number} completion.activity_id ID of the activity that was completed
    # @apiSuccess (200) {DateTime} completion.created_at The date and time the completion was created.
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiSuccessExample {type} Success-Response:
    # {
    #     property : value
    # }
    # 
    # 
    #*

    def create
        @completion = QuestCompletion.create(completion_params)
        return_the @completion
    end

    #**
    # 
    # @api {get} /quest_completion/:id Get a quest by completion id
    # @apiName GetCompletion
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # @apiParam  {Number} id ID of the completion
    # 
    # @apiSuccess (200) {Object} completion Container for the completion data
    # @apiSuccess (200) {Number} completion.id ID of the created completion
    # @apiSuccess (200) {Number} completion.person_id The ID of the user who completed the activity
    # @apiSuccess (200) {Number} completion.quest_id ID of the quest
    # @apiSuccess (200) {Number} completion.activity_id ID of the activity that was completed
    # @apiSuccess (200) {DateTime} completion.created_at The date and time the completion was created.
    # 
    # @apiParamExample  {json} Request-Example:
    # {
    #     "id" : 1
    # }
    # 
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    # }
    # 
    # 
    #*

    def show
        @completion = QuestCompletion.find(params[:id])
        return_the @completion
    end

    #**
    # 
    # @api {get} /quests/:id/completions/list Get a quest by completion id
    # @apiName apiName
    # @apiGroup group
    # @apiVersion  1.0.0
    # 
    # @apiParam {Number} [page] The page number to get. Default is 1.
    #
    # @apiParam {Number} [per_page] The pagination division. Default is 25.
    #
    # @apiParam {Number} [person_id_filter] Full match on person id.
    #
    # @apiParam {Number} [quest_id_filter] Full match on quest id.
    # 
    # @apiParam {Number} [activity_id_filter] Full match on activity id.
    #
    # @apiSuccess (200) {Object} completions Container for the completion data
    # @apiSuccess (200) {Number} completions.id ID of the created completion
    # @apiSuccess (200) {Number} completions.person_id The ID of the user who completed the activity
    # @apiSuccess (200) {Number} completions.quest_id ID of the quest
    # @apiSuccess (200) {Number} completions.activity_id ID of the activity that was completed
    # @apiSuccess (200) {DateTime} completions.created_at The date and time the completion was created.
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiSuccessExample {type} Success-Response:
    # {
    #     property : value
    # }
    # 
    # 
    #*

    def list
        @completions = paginate apply_filters
        return_the @completions
    end

    #**
    # 
    # @api {PATCH} /completion/:id Update a tracked completion
    # @apiName CompletionUpdate
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the completion being updated
    # @apiParam  {Number} [quest_id] The id of the quest the completion is associated with
    # @apiParam  {Number} [activity_id] The id of the completed activity
    # 
    # @apiSuccess (200) {type} name description
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiSuccessExample {type} Success-Response:
    # {
    #     property : value
    # }
    # 
    # 
    #*
    def update
        @completion.update_attributes(completion_params)
        return_the @completion
    end

    #**
    # @apiIngore
    # @api {DELETE} /completion/:id Soft delete a completion
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
        params.require(:completed).permit(:quest_id, :activity_id)
    end

end
  