class Api::V1::Docs::EventsDoc < Api::V1::Docs::BaseDoc
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
  #

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
  doc_tag name: 'Events', desc: "Events"
  route_base 'api/v1/events'

  components do
    resp :EventsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :events => [
        :event => :Event
      ]
    }]
    resp :EventsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :event => :Event
    }]
  end

  api :index, "Get all events for a product" do
    query :from_date, Date, desc: 'Only include events starting on or after date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :to_date, Date, desc: 'Only include events starting on or before date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    response_ref 200 => :EventsArray
  end

  api :show, "Get a single event by id" do
    response_ref 200 => :EventsObject
  end
end
