class Api::V1::ProductBeaconsController < ApiController
    include Rails::Pagination

    before_action :admin_only
    
    #**
    # @api {get} /admin/:product_internal_name/beacons Beacons for a product
    # @apiName ProductBeacons
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # 
    # @apiSuccess (200) {Object[]} name description
    # 
    # @apiParamExample  {type} Request-Example:
    # https://api.example.com/adnmin/admin/beacons
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
    # @api {get} /:product_internal_name/beacons/:id Get Beacon by id or it's product id
    # @apiName GetBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
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
    # @api {POST} /:product_internal_name/beacons title
    # @apiName CreateBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
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
    # @api {delete} /:product_internal_name/beacons/:id title
    # @apiName DeleteBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # 
    # @apiSuccess (200) {Header} header Returns a 200 response if successfull
    # 
    # @apiParamExample  {type} Request-Example:
    # https://api.example.com/admin/admin/1
    # 
    # or 
    #
    # https://api.examplpe.com/admin/admin/abcdef-123456
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