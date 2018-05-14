class Api::V1::QuestCompletedController < ApiController
    include Rails::Pagination

    #**
    # @apiIgnore Not Finished
    # @api {get} /quests/:id/completed Get users who completed the quest
    # @apiName QuestCompleted
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the quest
    # 
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # @apiSuccess (200) {Object[]} completed Container for users who completed a quest
    # 
    # 
    #*
    def index
    end

    def for_user
    end

    def show
    end

    def create
    end
end