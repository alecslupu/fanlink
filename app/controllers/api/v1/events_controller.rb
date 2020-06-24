# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      # **
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
      # *

      def index
        if !check_dates
          render json: { errors: 'Invalid date(s)' }, status: :unprocessable_entity
        else
          start_boundary = (params[:from_date].present?) ? Date.parse(params[:from_date]) : (Time.zone.now - 3.years).beginning_of_day
          end_boundary = (params[:to_date].present?) ? Date.parse(params[:to_date]) : (Time.zone.now + 3.years).end_of_day
          @events = Event.in_date_range(start_boundary, end_boundary).order(starts_at: :asc)
        end
      end

      # **
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
      # *

      def show
        @event = Event.find(params[:id])
        return_the @event
      end
    end
  end
end
