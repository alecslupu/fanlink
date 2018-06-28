class Api::V3::QuestCompletedController < Api::V3::BaseController
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
    # @apiParamExample  {json} Request-Example:
    # {
    #     property : value
    # }
    #
    # @apiSuccess (200) {Object[]} completed Container for users who completed a quest
    #
    #
    #*
    def index
      @quests_complete = QuestCompleted.where(person_id: current_user.id)
      return_the @quests_completed
    end

    def show
      @quest_complete = QuestCompleted.find(params[:id])
    end
private
end
