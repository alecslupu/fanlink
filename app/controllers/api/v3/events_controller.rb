class Api::V3::EventsController < Api::V3::BaseController
    load_up_the Event, only: %i[ update delete ]

    #**
    # @apiDefine EventSuccess
    #    Success object
    # @apiSuccessExample {json} Success-Response:
    # {
    #     "event": {
    #         "id": "1",
    #         "name": "Spectacular Event",
    #         "description": "THE event of the moment",
    #         "starts_at": "2018-02-24T00:25:11Z",
    #         "ends_at": "2018-08-23T23:25:11Z",
    #         "ticket_url": "http://example.com/buy_now",
    #         "place_identifier": "Sazuki"
    #     }
    # }
    #*

    #**
    # @apiDefine EventSuccessess
    #    Success Array
    # @apiSuccessExample {json} Success-Response:
    # {
    #     "events": [
    #         {
    #             "id": "1",
    #             "name": "Spectacular Event",
    #             "description": "THE event of the moment",
    #             "starts_at": "2018-02-24T00:30:56Z",
    #             "ends_at": "2018-08-23T23:30:56Z",
    #             "ticket_url": "http://example.com/buy_now",
    #             "place_identifier": "Montreal"
    #         },
    #         {
    #             "id": "2",
    #             "name": "Spectacular Event 2",
    #             "description": "THE event of the moment 2",
    #             "starts_at": "2018-02-24T00:31:15Z",
    #             "ends_at": "2018-08-23T23:31:15Z",
    #             "ticket_url": "http://example.com/buy_now",
    #             "place_identifier": "Sazuki"
    #         }
    #     ]
    # }
    #*

    #**
    # @apiDefine EventParams Form Params
    #    The params the events accept
    #
    # @apiParam (body) {Object} event Event container
    # @apiParam (body) {String} event.name String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
    # @apiParam (body) {String} [event.description] String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
    # @apiParam (body) {DateTime} event.starts_at The date and time the event starts at
    # @apiParam (body) {DateTime} [event.ends_at] The date and time the event ends at.
    # @apiParam (body) {String} [event.ticket_url] The url used for purchasing tickets to the event
    # @apiParam (body) {String} [event.place_identifier] Used for google maps API
    #*

      #**
  # @api {get} /events Get available events.
  # @apiName GetEvents
  # @apiGroup Events
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a list of events, in starts_at order.
  #
  # @apiParam (body) {String} [from_date]
  #   Only include events starting on or after date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.
  #
  # @apiParam (body) {String} [to_date]
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
      end_boundary = (params[:to_date].present?) ? Date.parse(params[:to_date]) : (Time.now + 3.years).end_of_day
      @events = Event.in_date_range(start_boundary, end_boundary).order(starts_at: :asc)
    end
  end

  #**
  # @api {get} /events/:id Get a single event.
  # @apiName GetEvent
  # @apiGroup Events
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This gets a single event for an event id.
  #
  # @apiParam (path)  {Number} id Event ID
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "event": [
  #       {
  #         "id": "5016",
  #         "name": "Some event",
  #         "description": "Some more about the event"
  #         "starts_at": "2018-01-08T12:00:00Z",
  #         "ends_at":  "2018-01-08T15:00:00Z",
  #         "ticket_url": "https://example.com/3455455",
  #         "place_identifier": "fdA3434Bdfad34134"
  #       },....
  #     ]
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*

  def show
    @event = Event.find(params[:id])
    return_the @event
  end

    #**
    #
    # @api {post} /events Create a events item
    # @apiName CreateEvents
    # @apiGroup Events
    # @apiVersion  2.0.0
    #
    #
    # @apiUse EventParams
    #
    #
    # @apiParamExample  {curl} Request-Example:
    # curl -X POST \
    # http://localhost:3000/events \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache' \
    # -H 'Content-Type: application/x-www-form-urlencoded' \
    # -d 'event%5Bname%5D=Spectacular%20Event&event%5Bdescription%5D=THE%20event%20of%20the%20moment&event%5Bstarts_at%5D=2018-02-24T00%3A25%3A11.539Z&event%5Bends_at%5D=2018-08-23T23%3A25%3A11.539Z&event%5Bticket_url%5D=http%3A%2F%2Fexample.com%2Fbuy_now&event%5Bplace_identifier%5D=Sazuki'
    #
    # @apiUse EventSuccess
    #
    #*

    def create
        @event = Event.create(event_params)
        if @event.valid?
            broadcast(:event_created, current_user, @event)
            return_the @event
        else
            render json: { errors: @event.errors.messages.flatten }, status: :unprocessable_entity
        end
    end

    #**
    #
    # @api {patch} /events/:id Update a events item
    # @apiName UpdateEvents
    # @apiGroup Events
    # @apiVersion  2.0.0
    #
    # @apiParam (path) {Number} id ID of the event to updated
    #
    # @apiUse EventParams
    #
    # @apiParamExample  {curl} Request-Example:
    # curl -X PATCH \
    # http://localhost:3000/events/1 \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache' \
    # -H 'Content-Type: application/x-www-form-urlencoded' \
    # -d event%5Bplace_identifier%5D=Montreal
    #
    # @apiUse EventSuccess
    #
    #
    #*

    def update
        if @event.update_attributes(event_params)
            broadcast(:event_updated, current_user, @event)
            return_the @event
        else
            render json: { errors: @event.errors.messages }, status: :unprocessable_entity
        end
    end

    #**
    #
    # @api {destroy} /events/:id Destroy events
    # @apiName DestroyMerchandsie
    # @apiGroup Events
    # @apiVersion  2.0.0
    #
    #
    # @apiParam (path) {Number} id ID of the event being deleted
    #
    #
    # @apiParamExample  {curl} Request-Example:
    # {
    #     property : value
    # }
    #
    #
    # @apiUse EventSuccess
    #
    #
    #*

    def destroy
        if current_user.some_admin?
            @event.deleted = true
            @event.save
            head :ok
        else
          render_not_found
        end
    end

private
    def event_params
        params.require(:event).permit( :name, :description, :starts_at, :ends_at, :ticket_url, :place_identifier )
    end

end
