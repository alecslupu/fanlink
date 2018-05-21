class Api::V2::QuestCompletedController < ApiController
    include Rails::Pagination
    include Wisper::Publisher
    
    #**
    # @apiIgnore Not Finished
    # @api {get} /quests/:id/completed Get users who completed the quest
    # @apiName QuestCompleted
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam (path) {Integer} id ID of the quest
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
        @completed = QuestCompleted.create(completed_params)
        if @completed.valid?
            return_the @completed
        else
            render json: { errors: @completed.errors.messages }, status: :unprocessable_entity
        end
    end
private 
    def completed_params
        params.require(:completed).permit()
    end
end