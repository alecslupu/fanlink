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
    # @apiParamExample  {url} Request-Example:
    # {
    #     "url": "https://api.example.com/admin/admin/beacons"
    # }
    # 
    # @apiSuccessExample {type} Success-Response:
    # {
    #     "product_beacons": [
    #       {
    #         "id": 1,
    #         "product_id": 1,
    #         "beacon_pid": "abcdef-123456",
    #         "attached_to": 1,
    #         "created_at": "Datetime"
    #      }
    #    ]
    # }
    # 
    # 
    #*

    def index
        @product_beacons = paginate(ProductBeacon.where.not(deleted: true))
        return_the @product_beacons
    end

    #**
    # 
    # @api {get} /admin/:product_internal_name/beacons/list Get a list of all beacons.
    # @apiName GetBeaconsList
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Name of the product
    #
    # @apiParam {Integer} [page]  The page number to get. Default is 1.
    #
    # @apiParam {Integer} [per_page] The pagination division. Default is 25.
    # 
    # @apiSuccess (200) {json} beacons A list of all the beacons
    # 
    # @apiParamExample  {url} Request-Example:
    # {
    #     "url": "https://api.example.com/admin/admin/beacons/list"
    # }
    # 
    # @apiSuccessExample {type} Success-Response:
    # {
    #     "product_beacons": [
    #       {
    #         "id": 1,
    #         "product_id": 1,
    #         "beacon_pid": "abcdef-123456",
    #         "attached_to": 1,
    #         "deleted": false,
    #         "created_at": "Datetime"
    #      }
    #    ]
    # }
    # 
    # 
    #*

    def list
        @product_beacons = paginate
        return_the @product_beacons
    end

    #**
    # @api {get} /admin/:product_internal_name/beacons/:id Get Beacon by id or it's product id
    # @apiName GetBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    #
    # @apiParam  {Number} id ID of beacon
    # 
    # @apiParam  {String} id Product ID of beacon
    #
    # @apiSuccess (200) {Object} product_beacon The product beacon object
    # 
    # @apiParamExample  {Url} Request-Example:
    # {
    #     "id" : "https://api.example.com/admin/admin/beacons/1",
    #     "pid": "https://api.example.com/admin/admin/beacons/abcdef-123456"
    # }
    # 
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "product_beacon": {
    #         "id": 1,
    #         "product_id": 1,
    #         "beacon_pid": "abcdef-123456",
    #         "attached_to": 1,
    #         "created_at": "Datetime"
    #      }
    # }
    # 
    # 
    #*

    def show
        @product_beacon = ProductBeacons.where.not(deleted: true).for_id_or_pid(params[:id]);
        return_the @product_beacon
    end

    #**
    # @api {post} /admin/:product_internal_name/beacons Add a beacon to a product
    # @apiName CreateBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # @apiParam  {Object} product_beacon The product beacon container
    # @apiParam  {String} product_beacon.beacon_pid The Beacon's product id listed on the box
    # @apiParam  {Number} [attached_to] The activity the beacon is attached to.
    # 
    # @apiSuccess (200) {Object} beacon Returns the newly created beacon
    # 
    # @apiParamExample  {Url} Request-Example:
    # {
    #     "url" : "https://api.example.com/admin/admin/beacons"
    # }
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "product_beacon": {
    #         "id": 1,
    #         "product_id": 1,
    #         "beacon_pid": "abcdef-123456",
    #         "attached_to": 1,
    #         "created_at": "Datetime"
    #      }
    # }
    # 
    # 
    #*

    def create
        @product_beacon = ProductBeacon.create(beacon_params)
        return_the @product_beacon
    end

    #**
    # 
    # @api {patch} /admin/:product_internal_name/beacons/:id Update a beacon
    # @apiName BeaconUpdate
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # @apiParam  {Object} product_beacon The product beacon container
    # @apiParam  {Number} [attached_to] The activity the beacon is attached to.
    # 
    # @apiSuccess (200) {Object} product_beacon Returns the updated beacon
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     "product_beacon": {
    #         "attached_to": 1
    #     }
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
        @product_beacon.update_attributes(beacon_update_params)
        return_the @product_beacon
    end

    #**
    # @api {delete} /admin/:product_internal_name/beacons/:id title
    # @apiName DeleteBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # 
    # @apiSuccess (200) {Header} header Returns a 200 response if successful
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     "id" : "https://api.example.com/admin/admin/beacons/1",
    #     "pid": "https://api.example.com/admin/admin/beacons/abcdef-123456"
    # }
    # 
    # @apiSuccessExample {Header} Success-Response:
    # HTTP/1.1 200 OK
    # 
    # 
    #*

    def destroy
        beacon = ProductBeacon.for_id_or_pid(params[:id])
        if current_user.some_admin?
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
    
    def beacon_update_params
        params.require(:product_beacon).permit(:attached_to)
    end
end