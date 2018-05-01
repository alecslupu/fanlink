class Api::V1::ProductBeaconsController < ApiController
    include Rails::Pagination

    before_action :admin_only
    
    #**
    # @apiIgnore
    # @api {get} /admin/:product_internal_name/beacons Beacons for a product
    # @apiName ProductBeacons
    # @apiGroup Product
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # 
    # @apiSuccess (200) {Object[]} name description
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

    def index
        @beacons = paginate
        return_the @beacons
    end

    #**
    # @apiIgnore
    # @api {method} /path title
    # @apiName apiName
    # @apiGroup group
    # @apiVersion  major.minor.patch
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
    # @apiSuccessExample {type} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     property : value
    # }
    # 
    # 
    #*

    def show
        @beacon = ProductBeacons.find(params[:id]);
        return_the @beacon
    end

    #**
    # @apiIgnore
    # @api {method} /path title
    # @apiName apiName
    # @apiGroup group
    # @apiVersion  major.minor.patch
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
    # @apiSuccessExample {json} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     property : value
    # }
    # 
    # 
    #*

    def create
        @beacon = ProductBeacon.create(beacon_params)
        return_the @quest
    end

    #**
    # @apiIgnore
    # @api {method} /path title
    # @apiName apiName
    # @apiGroup group
    # @apiVersion  major.minor.patch
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
    # @apiSuccessExample {type} Success-Response:
    # HTTP/1.1 200 OK
    # 
    # 
    #*

    def destroy
        beacon = ProductBeacon.find(params[:id])
        if current_user.some_admin
          beacon.deleted = true
          head :ok
        else
          render_not_found
        end    
    end

private

    def beacon_params
        params.require(:product_beacon).permit(:beacon_pid, :attached_to)
    end    
end