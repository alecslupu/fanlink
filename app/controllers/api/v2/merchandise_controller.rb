class Api::V2::MerchandiseController < Api::V1::MerchandiseController
    include Wisper::Publisher
    load_up_the Merchandise, only: %i[ update delete ]
    #**
    # @apiDefine Success
    #    Success object 
    #*

    #**
    # @apiDefine Successess
    #    Success Array 
    #*

    #**
    # 
    # @api {post} /merchandise Create a merchandise item
    # @apiName CreateMerchandise
    # @apiGroup Merchandise
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {String} paramName description
    # 
    # @apiSuccess (200) {type} name description
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiUse Success
    # 
    #*
    def create
        @merchandise = Merchandise.create(merchandise_params)
        if @merchandise.valid?
            broadcast(:merchandise_created, current_user, @merchandise)
            return_the @merchandise
        else
            render json: { errors: @merchandise.errors.messages.flatten }, status: :unprocessable_entity
        end
    end

    #**
    # 
    # @api {patch} /merchandise Update a merchandise item
    # @apiName UpdateMerchandise
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {String} paramName description
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiUse Success
    # 
    # 
    #*

    def update
        @merchandise.update_attributes(merchandise_params)
        if @merchandise.valid?
            broadcast(:merchandise_updated, current_user, @merchandise)
            return_the @merchandise
        else
            render json: { errors: @merchandise.errors.messages }, status: :unprocessable_entity
        end
    end

    #**
    # 
    # @api {destroy} /merchandise Destroy merchandise
    # @apiName DestroyMerchandsie
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {String} paramName description
    # 
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiUse Success
    # 
    # 
    #*

    def destroy
        if current_user.some_admin?
            @merchandise.deleted = true
            @merchandise.save
            head :ok
        else
          render_not_found
        end 
    end

private
    def merchandise_params
        params.require(:marchandise).permit()
    end
end
