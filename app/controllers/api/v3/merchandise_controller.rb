# frozen_string_literal: true

class Api::V3::MerchandiseController < Api::V2::MerchandiseController
  before_action :admin_only, only: %i[create update destroy]
  load_up_the Merchandise, only: %i[update show delete]
  # **
  # @apiDefine MerchandiseSuccess
  #    Success object
  # *

  # **
  # @apiDefine MerchandiseSuccessess
  #    Success Array
  # *

  # **
  # @apiDefine MerchandiseParams Form Parameters
  #    Parameters that are accepted for Merchandise
  #
  # @apiParam (body) {Object} merchandise Object container
  # @apiParam (body) {String} merchandise.name Name of the item.
  # @apiParam (body) {String} merchandise.description Description of the item.
  # @apiParam (body) {String} [merchandise.price] Price of the item
  # @apiParam (body) {File} [merchandise.picture] Image associated with the item
  # @apiParam (body) {Boolean} merchandise.available Is the item currently available? True/false
  # @apiParam (body) {Number} merchandise.priority Importance?
  # @apiParam (body) {String} [merchandise.purchase_url] The URL to purchase the item
  # *

  # **
  # @api {get} /merchandise Get available merchandise.
  # @apiName GetMerchandise
  # @apiGroup Merchandise
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of merchandise, in priority order.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "merchandise": [
  #       { ....merchandise json..see get single merchandise action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401 Unauthorized
  # *

  def index
    @merchandise = paginate(Merchandise.listable.order(:priority))
    return_the @merchandise
  end

  # **
  # @api {get} /merchandise/:id Get a single piece of merchandise.
  # @apiName GetMerchandise
  # @apiGroup Merchandise
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single piece of merchandise for a merchandise id.
  #
  # @apiParam (path) {Number} id Merchandise ID
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "merchandise": [
  #       {
  #         "id": "5016",
  #         "name": "Something well worth the money",
  #         "description": "Bigger than a breadbox"
  #         "price": "$4.99",
  #         "purchase_url": "https://amazon.com/3455455",
  #         "picture_url": "https://example.com/hot.jpg"
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  # *

  def show
    @merchandise = Merchandise.listable.find(params[:id])
    return_the @merchandise
  end

  # **
  #
  # @api {post} /merchandise Create a merchandise item
  # @apiName CreateMerchandise
  # @apiGroup Merchandise
  # @apiVersion  2.0.0
  #
  #
  # @apiUse MerchandiseParams
  #
  # @apiParamExample  {curl} Request-Example:
  # curl -X POST \
  # http://localhost:3000/merchandise \
  # -H 'Accept: application/vnd.api.v2+json' \
  # -H 'Cache-Control: no-cache' \
  # -H 'Content-Type: application/x-www-form-urlencoded' \
  # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  # -F 'merchandise[name]=Sample Merch' \
  # -F 'merchandise[description]=This is a test. This is only a test' \
  # -F 'merchandise[price]=3.99' \
  # -F 'merchandise[available]=Yes' \
  # -F 'merchandise[priority]=1' \
  # -F 'merchandise[purchase_url]=http://example.com/sample' \
  # -F 'merchandise[picture]=@D:\Media\Pictures\turing_test.png'
  #
  #
  # @apiUse MerchandiseSuccess
  #
  # *

  def create
    @merchandise = Merchandise.create(merchandise_params)
    if @merchandise.valid?
      broadcast(:merchandise_created, current_user, @merchandise)
      return_the @merchandise
    else
      render_422 @merchandise.errors
    end
  end

  # **
  #
  # @api {patch} /merchandise/:id Update a merchandise item
  # @apiName UpdateMerchandise
  # @apiGroup Merchandise
  # @apiVersion  2.0.0
  #
  # @apiParam (path) {Number} id ID of the item you're updating
  #
  # @apiUse MerchandiseParams
  #
  # @apiParamExample  {curl} Request-Example:
  # curl -X PATCH \
  # http://localhost:3000/merchandise/1 \
  # -H 'Accept: application/vnd.api.v2+json' \
  # -H 'Cache-Control: no-cache' \
  # -H 'Content-Type: application/x-www-form-urlencoded' \
  # -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  # -F 'merchandise[price]=39.99'
  #
  #
  # @apiUse MerchandiseSuccess
  #
  #
  # *

  def update
    if params.has_key?(:merchandise)
      if @merchandise.update(merchandise_params)
        broadcast(:merchandise_updated, current_user, @merchandise)
        return_the @merchandise
      else
        render_422 @merchandise.errors
      end
    else
      return_the @merchandise
    end
  end

  # **
  #
  # @api {destroy} /merchandise/:id Destroy merchandise
  # @apiName DestroyMerchandsie
  # @apiGroup Merchandise
  # @apiVersion  2.0.0
  #
  #
  # @apiParam (path) {Number} id ID of the merchandise to be deleted
  #
  #
  # @apiParamExample  {curl} Request-Example:
  # curl -X DELETE \
  # http://localhost:3000/merchandise/1 \
  # -H 'Accept: application/vnd.api.v2+json' \
  # -H 'Cache-Control: no-cache' \
  # -H 'Content-Type: application/x-www-form-urlencoded'
  #
  #
  # @apiUse MerchandiseSuccess
  #
  #
  # *

  def destroy
    if some_admin?
      if @merchandise.update(deleted: true)
        head :ok
      else
        render_422(_("Failed to delete the merchandise."))
      end
    else
      render_not_found
    end
  end

private
  def merchandise_params
    params.require(:merchandise).permit(:price, :picture, :available, :priority, :name, :description, :purchase_url)
  end
end
