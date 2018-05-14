class Api::V1::ProductBeaconsController < ApiController
    include Rails::Pagination

    before_action :admin_only
    
    #**
    # @api {get} /beacons Beacons for a product
    # @apiName ProductBeacons
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # @apiParam {Integer} [page]  The page number to get. Default is 1.
    #
    # @apiParam {Integer} [per_page] The pagination division. Default is 25.
    # 
    # @apiSuccess (200) {Object} beacons Beacons container
    # @apiSuccess (200) {Number} beacons.id Beacon ID
    # @apiSuccess (200) {Number} beacons.product_id Product ID the beacon is registered to
    # @apiSuccess (200) {String} beacons.beacon_pid The beacon product id located on the box
    # @apiSuccess (200) {UUID} beacons.uuid Beacon UUID
    # @apiSuccess (200) {Number} beacons.lower Lower
    # @apiSuccess (200) {Number} beacons.upper Upper
    # @apiSuccess (200) {Number} beacons.attached_to The activity the beacon is attached to. Can be null.
    # @apiSuccess (200) {Datetime} beacons.created_at The date and time the beacon was added to the database.
    #
    # @apiParamExample  {url} Request-Example:
    # {
    #     "url": "https://api.example.com/beacons"
    # }
    # 
    # @apiSuccessExample {json} Success-Response:
    # {
    #     "beacons": [
    #       "id": "1",
    #         "product_id": "1",
    #         "beacon_pid": "A12FC4-12912",
    #         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
    #         "lower": "25",
    #         "upper": "75",
    #         "attached_to": null,
    #         "created_at": "2018-05-09T21:52:48.653Z"
    #    ]
    # }
    # 
    # 
    #*

    def index
        @product_beacons = paginate(ProductBeacon.where.not(deleted: true).order(created_at: :desc))
        return_the @product_beacons
    end

    #**
    # 
    # @api {get} /beacons/list Get a list of all beacons.
    # @apiName GetBeaconsList
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    #
    # @apiParam {Integer} [page]  The page number to get. Default is 1.
    #
    # @apiParam {Integer} [per_page] The pagination division. Default is 25.
    # 
    # @apiSuccess (200) {Object} beacons A list of all the beacons
    # @apiSuccess (200) {Number} beacons.id Beacon ID
    # @apiSuccess (200) {Number} beacons.product_id Product ID the beacon is registered to
    # @apiSuccess (200) {String} beacons.beacon_pid The beacon product id located on the box
    # @apiSuccess (200) {UUID} beacons.uuid Beacon UUID
    # @apiSuccess (200) {Number} beacons.lower Lower
    # @apiSuccess (200) {Number} beacons.upper Upper
    # @apiSuccess (200) {Boolean} beacons.deleted Is set to true if a beacon has been soft deleted.
    # @apiSuccess (200) {Number} beacons.attached_to The activity the beacon is attached to. Can be null.
    # @apiSuccess (200) {Datetime} beacons.created_at The date and time the beacon was added to the database.
    #
    # @apiParamExample  {url} Request-Example:
    # {
    #     "url": "https://api.example.com/product_beacons/list"
    # }
    # 
    # @apiSuccessExample {json} Success-Response:
    # {
    #     "beacons": [
    #       "id": "1",
    #         "product_id": "1",
    #         "beacon_pid": "A12FC4-12912",
    #         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
    #         "lower": "25",
    #         "upper": "75",
    #         "attached_to": null,
    #         "created_at": "2018-05-09T21:52:48.653Z"
    #    ]
    # }
    # 
    # 
    #*

    def list
        @product_beacons = paginate(ProductBeacon.where("product_id =?", ActsAsTenant.current_tenant.id))
        return_the @product_beacons
    end

    #**
    # @api {get} /beacons/:id Get Beacon by id or it's product id
    # @apiName GetBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    #
    # @apiParam  {Number} id ID of beacon
    # 
    # @apiParam  {String} id Product ID of beacon
    #
    # @apiSuccess (200) {Object} beacon The product beacon object
    # @apiSuccess (200) {Number} beacon.id Beacon ID
    # @apiSuccess (200) {Number} beacon.product_id Product ID the beacon is registered to
    # @apiSuccess (200) {String} beacon.beacon_pid The beacon product id located on the box
    # @apiSuccess (200) {UUID} beacon.uuid Beacon UUID
    # @apiSuccess (200) {Number} beacon.lower Lower
    # @apiSuccess (200) {Number} beacon.upper Upper
    # @apiSuccess (200) {Number} beacon.attached_to The activity the beacon is attached to. Can be null.
    # @apiSuccess (200) {Datetime} beacon.created_at The date and time the beacon was added to the database.
    # 
    # @apiParamExample  {Url} Request-Example:
    # {
    #     "id" : "https://api.example.com/product_beacons/1",
    #     "pid": "https://api.example.com/product_beacons/abcdef-123456"
    # }
    # 
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "beacon": {
    #         "id": "1",
    #         "product_id": "1",
    #         "beacon_pid": "A12FC4-12912",
    #         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
    #         "lower": "25",
    #         "upper": "75",
    #         "attachd_to": "",
    #         "created_at": "2018-05-09T21:52:48.653Z"
    #     }
    # }
    # 
    # 
    #*

    def show
        @product_beacon = ProductBeacon.where.not(deleted: true).for_id_or_pid(params[:id]);
        return_the @product_beacon
    end

    #**
    # @api {post} /product_beacons Add a beacon to a product
    # @apiName CreateBeacon
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # @apiParam  {Object} product_beacon The product beacon container
    # @apiParam  {String} product_beacon.beacon_pid The Beacon's product id listed on the box
    # @apiParam  {UUID} product_beacon.uuid Beacon UUID
    # @apiParam  {Number} product_beacon.lower Lower
    # @apiParam  {Nummber} product_beacon.upper Upper
    # @apiParam  {Number} [attached_to] The activity the beacon is attached to.
    # 
    # @apiSuccess (200) {Object} beacon Returns the newly created beacon
    # @apiSuccess (200) {Number} beacon.id Beacon ID
    # @apiSuccess (200) {Number} beacon.product_id Product ID the beacon is registered to
    # @apiSuccess (200) {String} beacon.beacon_pid The beacon product id located on the box
    # @apiSuccess (200) {UUID} beacon.uuid Beacon UUID
    # @apiSuccess (200) {Number} beacon.lower Lower
    # @apiSuccess (200) {Number} beacon.upper Upper
    # @apiSuccess (200) {Number} beacon.attached_to The activity the beacon is attached to. Can be null.
    # @apiSuccess (200) {Datetime} beacon.created_at The date and time the beacon was added to the database.
    # 
    # @apiParamExample  {Url} Request-Example:
    # {
    #     "url" : "https://api.example.com/product_beacons"
    # }
    # 
    # @apiSuccessExample {Object} Success-Response:
    # HTTP/1.1 200 OK
    # {
    #     "beacon": {
    #         "id": "1",
    #         "product_id": "1",
    #         "beacon_pid": "A12FC4-12912",
    #         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
    #         "lower": "25",
    #         "upper": "75",
    #         "attachd_to": "",
    #         "created_at": "2018-05-09T21:52:48.653Z"
    #     }
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
    # @api {patch} /product_beacons/:id Update a beacon
    # @apiName BeaconUpdate
    # @apiGroup Beacons
    # @apiVersion  1.0.0
    # 
    # 
    # @apiParam  {String} product_internal_name Internal name of the product
    # @apiParam  {Object} product_beacon The product beacon container
    # @apiParam  {UUID} [product_beacon.uuid] Beacon UUID
    # @apiParam  {Number} [product_beacon.lower] Lower
    # @apiParam  {Number} [product_beacon.upper] Upper
    # @apiParam  {Number} [product_beacon.attached_to] The activity the beacon is attached to.
    # 
    # @apiSuccess (200) {Object} beacon The response beacon container
    # @apiSuccess (200) {Number} beacon.id Beacon ID
    # @apiSuccess (200) {Number} beacon.product_id Product ID the beacon is registered to
    # @apiSuccess (200) {String} beacon.beacon_pid The beacon product id located on the box
    # @apiSuccess (200) {UUID} uuid Beacon UUID
    # @apiSuccess (200) {Number} lower Lower
    # @apiSuccess (200) {Number} upper Upper
    # @apiSuccess (200) {Number} beacon.attached_to The activity the beacon is attached to. Can be null.
    # @apiSuccess (200) {Datetime} beacon.created_at The date and time the beacon was added to the database.
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
    # HTTP/1.1 200 OK
    # {
    #     "beacon": {
    #         "id": "1",
    #         "product_id": "1",
    #         "beacon_pid": "A12FC4-12912",
    #         "uuid": "eae4c812-bcfb-40e8-9414-b5b42826dcfb",
    #         "lower": "25",
    #         "upper": "75",
    #         "attachd_to": "",
    #         "created_at": "2018-05-09T21:52:48.653Z"
    #     }
    # }
    # 
    #*

    def update
        @product_beacon.update_attributes(beacon_update_params)
        return_the @product_beacon
    end

    #**
    # @api {delete} /product_beacons/:id title
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
    #     "id" : "https://api.example.com/product_beacons/1",
    #     "pid": "https://api.example.com/product_beacons/abcdef-123456"
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
        params.require(:product_beacon).permit(:beacon_pid, :attached_to, :uuid, :lower, :upper)
    end    
    
    def beacon_update_params
        params.require(:product_beacon).permit(:attached_to, :uuid, :lower, :upper)
    end
end