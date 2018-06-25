class Api::V2::EventsController < Api::V1::EventsController
    include Rails::Pagination
    include Wisper::Publisher
    include Swagger::Blocks
    load_up_the Event, only: %i[ update delete ]

    #**
    # @apiDefine Success
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
    # @apiDefine Successess
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
    # @apiDefine Params Form Params
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
    #
    # @api {post} /events Create a events item
    # @apiName CreateEvents
    # @apiGroup Events
    # @apiVersion  2.0.0
    #
    #
    # @apiUse Params
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
    # @apiUse Success
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
    # @apiUse Params
    #
    # @apiParamExample  {curl} Request-Example:
    # curl -X PATCH \
    # http://localhost:3000/events/1 \
    # -H 'Accept: application/vnd.api.v2+json' \
    # -H 'Cache-Control: no-cache' \
    # -H 'Content-Type: application/x-www-form-urlencoded' \
    # -d event%5Bplace_identifier%5D=Montreal
    #
    # @apiUse Success
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
    # @apiUse Success
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
