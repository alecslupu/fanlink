# frozen_string_literal: true

module Api
  module V3
    class EventsController < Api::V2::EventsController
      before_action :admin_only, only: %i[create update destroy]
      skip_before_action :require_login, only: %i[index]
      load_up_the Event, only: %i[update delete]

      # **
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
      #         "latitude": -37.123121,
      #         "longitude": 101.121,
      #         "ticket_url": "http://example.com/buy_now",
      #         "place_identifier": "Sazuki"
      #     }
      # }
      # *

      # **
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
      #             "latitude": -37.123121,
      #             "longitude": 101.121,
      #             "ticket_url": "http://example.com/buy_now",
      #             "place_identifier": "Montreal"
      #         },
      #         {
      #             "id": "2",
      #             "name": "Spectacular Event 2",
      #             "description": "THE event of the moment 2",
      #             "starts_at": "2018-02-24T00:31:15Z",
      #             "ends_at": "2018-08-23T23:31:15Z",
      #             "latitude": -37.123121,
      #             "longitude": 101.121,
      #             "ticket_url": "http://example.com/buy_now",
      #             "place_identifier": "Sazuki"
      #         }
      #     ]
      # }
      # *

      # **
      # @apiDefine EventParams Form Params
      #    The params the events accept
      #
      # @apiParam (body) {Object} event Event container
      # @apiParam (body) {String} event.name String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
      # @apiParam (body) {String} [event.description] String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
      # @apiParam (body) {DateTime} event.starts_at The date and time the event starts at
      # @apiParam (body) {DateTime} [event.ends_at] The date and time the event ends at.
      # @apiParam (body) {Float} [event.longitude] The optional longitude for the location
      # @apiParam (body) {Float} [event.latitude] The optional latitude for the location
      # @apiParam (body) {String} [event.place_identifier] Used for google maps API
      # *

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
          render json: {errors: _('Invalid date(s)')}, status: :unprocessable_entity
        else
          start_boundary = (params[:from_date].present?) ? Date.parse(params[:from_date]) : (Time.zone.now - 3.years).beginning_of_day
          end_boundary = (params[:to_date].present?) ? Date.parse(params[:to_date]) : (Time.zone.now + 3.years).end_of_day
          query = (current_user&.role == 'super_admin') ? Event : Event.where(deleted: false)
          @events = paginate(query.in_date_range(start_boundary, end_boundary).order(starts_at: :asc))
          return_the @events, handler: tpl_handler
        end
      end

      def checkins
        interests = params[:interst_id] || []
        if interests.empty?
          @event_checkins = paginate(@event.event_checkins.includes(:person).order(created_at: :desc), per_page: 2)
        else
          @event_checkins = paginate(@event.event_checkins.includes(:person).joins(person: :person_interests).where('person_interests.interest_id IN (?)', interests).order(created_at: :desc))
        end

        return_the @event_checkins, handler: tpl_handler
      end

      def checkin
        @event_checkin = EventCheckin.create(person_id: current_user.id, event_id: @event.id)
        if @event_checkin.valid?
          return_the @event_checkin, handler: tpl_handler
        else
          render json: {errors: [@event_checkin.errors.messages]}, status: :unprocessable_entity
        end
      end

      def checkout
        ci = EventCheckin.where(person_id: current_user.id, event_id: @event.id).first

        if ci != nil
          ci.destroy
          head :ok
        else
          head :not_found
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
      #         "latitude": -37.123121,
      #         "longitude": 101.121,
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
        return_the @event, handler: tpl_handler
      end

      # **
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
      # *

      def create
        @event = Event.create(event_params)
        if @event.valid?
          broadcast(:event_created, current_user, @event)
          return_the @event, handler: tpl_handler, using: :show
        else
          render_422 @event.errors
        end
      end

      # **
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
      # *

      def update
        if params.has_key?(:event)
          if @event.update(event_params)
            broadcast(:event_updated, current_user, @event)
            return_the @event, handler: tpl_handler, using: :show
          else
            render_422 @event.errors
          end
        else
          return_the @event, handler: tpl_handler, using: :show
        end
      end

      # **
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
      # *

      def destroy
        if some_admin?
          if @event.update(deleted: true)
            head :ok
          else
            render_error(_('Failed to delete the event.'))
          end
        else
          render_not_found
        end
      end

      protected

      def tpl_handler
        'jb'
      end

      private

      def event_params
        params.require(:event).permit(:name, :description, :starts_at, :ends_at, :ticket_url, :place_identifier, :longitude, :latitude)
      end
    end
  end
end
