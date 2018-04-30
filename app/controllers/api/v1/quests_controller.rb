class Api::V1::QuestsController < ApiController
    include Rails::Pagination

    before_action :admin_only, except: %i[ index show ]

    #**
    # 
    # @api {GET} /quests Get quests for a product
    # @apiName GetQuests
    # @apiGroup Quests
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product Product name. Uses current_user if not passed.
    # 
    # @apiSuccess (200) {Array} data List of quests for product
    # 
    # @apiParamExample  {string} Request-Example:
    # {
    #     product : admin
    # }
    # 
    # 
    # @apiSuccessExample {Array} Success-Response:
    # {
    #   [
    #        {
    #            quest_id: 1,
    #            product_id: 1,
    #            event_id: 99,
    #            name: "My New Quest",
    #            description: "Find Waldy",
    #            picture: {object},
    #            status: "enabled",
    #            starts_at: 2031-08-18T10:22:08Z,
    #            ends_at: 2033-08-18T10:22:08Z
    #            
    #        },
    #        {
    #            quest_id: 2,
    #            product_id: 1,
    #            event_id: 102,
    #            name: "Don't get caught",
    #            description: "Steal the Declaration of Independence",
    #            picture: {object},
    #            status: "enabled",
    #            starts_at: 1776-07-04T10:22:08Z,
    #            ends_at: 2004-11-19T10:22:08Z
    #       },
    #    ]
    # }
    #*
    def index
        @quests = paginate(Quest.where.not(status: :deleted))
        return_the @quests
    end
    
    def show
        @quest = Quest.where.not(status: :deleted).find(params[:id])
        return_the @quest
    end

    def create
        @quest = Quest.create(quest_params)
        return_the @quest
    end

    def list
        @quests = paginate apply_filters
        return_the @quests
    end

    def destroy
        quest = Quest.find(params[:id])
        if current_user.some_admin
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
        params.require(:quest).permit(:name, :internal_name, :description, :status, :starts_at, :ends_at, quest_activities: %i[ description hint post image audio requires ])
    end    
end