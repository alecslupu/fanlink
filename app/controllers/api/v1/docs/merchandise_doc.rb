class Api::V1::Docs::MerchandiseDoc < Api::V1::Docs::BaseDoc
  #**
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
  #*

  #**
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
  #*
  doc_tag name: 'Merchandise', desc: "Product Merchandise"
  route_base 'api/v1/merchandise'

  components do
    resp :MerchandiseArray => ['HTTP/1.1 200 Ok', :json, data:{
      :merchandise => [
        :merchandise => :Merchandise
      ]
    }]
    resp :MerchandiseObject => ['HTTP/1.1 200 Ok', :json, data:{
      :merchandise => :Merchandise
    }]
  end
end
