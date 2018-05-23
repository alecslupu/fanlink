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
    # @apiDefine Params Form Parameters
    #    Parameters that are accepted for Merchandise
    #
    # @apiParam  {Object} merchandise Object container
    # @apiParam  {Object|String} merchandise.name Name of the item.
    # @apiParam  {Object|String} merchandise.description Description of the item.
    # @apiParam  {String} [merchandise.price] Price of the item
    # @apiParam  {File} [merchandise.picture] Image associated with the item
    # @apiParam  {Boolean} merchandise.available Is the item currently available? True/false
    # @apiParam  {Number} merchandise.priority Importance? 
    # @apiParam  {String} [merchandise.purchase_url] The URL to purchase the item
    #*

    #**
    # 
    # @api {post} /merchandise Create a merchandise item
    # @apiName CreateMerchandise
    # @apiGroup Merchandise
    # @apiVersion  2.0.0
    # 
    # 
    # @apiUse Params
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
    # @apiUse Params
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
    # @api {destroy} /merchandise/:id Destroy merchandise
    # @apiName DestroyMerchandsie
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the merchandise to be deleted
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
        params.require(:marchandise).permit(%i[ price, picture, available, priority, name, description, purchase_url ])
    end
end
