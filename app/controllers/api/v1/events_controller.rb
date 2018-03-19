class Api::V1::EventsController < ApiController
  #**
  # @api {get} /events Get available events.
  # @apiName GetEvents
  # @apiGroup Events
  #
  # @apiDescription
  #   This gets a list of events, in starts_at order.
  #
  # @apiParam {String} [from_date]
  #   Only include events starting on or after date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam {String} [to_date]
  #   Only include events starting on or before date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.

  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "events": [
  #       { ....event json..see get single event action ....
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 401 Unauthorized
  #*
  def index
    if !check_dates
      render json: { errors: "Invalid date(s)" }, status: :unprocessable_entity
    else
      start_boundary = (params[:from_date].present?) ? Date.parse(params[:from_date]) : (Time.now - 3.years).beginning_of_day
      end_boundary = (params[:to_date].present?) ? Date.parse(params[:from_date]) : (Time.now + 3.years).end_of_day
      @events = Event.in_date_range(start_boundary, end_boundary).order(starts_at: :asc)
    end
  end

  #**
  # @api {get} /merchandise/:id Get a single piece of merchandise.
  # @apiName GetMerchandise
  # @apiGroup Merchandise
  #
  # @apiDescription
  #   This gets a single piece of merchandise for a merchandise id.
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
  def show
    @merchandise = Merchandise.listable.find(params[:id])
    return_the @merchandise
  end
end