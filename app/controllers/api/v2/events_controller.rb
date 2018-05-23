class Api::V2::EventsController < Api::V1::EventsController
    include Wisper::Publisher
    load_up_the Event, only: %i[ update delete ]
    #**
    # @apiDefine Success
    #    Success object 
    #*

    #**
    # @apiDefine Successess
    #    Success Array 
    #*

    #**
    # @apiDefine Params Form Params
    #    The params the events accept
    #
    # @apiParam  {Object} event Event container
    # @apiParam  {Object|String} event.name String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
    # @apiParam  {Object|String} [event.description] String or Object. Passing a string sets the unknown language. Passing an object lets you set the translated language
    # @apiParam  {DateTime} event.starts_at The date and time the event starts at
    # @apiParam  {DateTime} [event.ends_at] The date and time the event ends at.
    # @apiParam  {String} [event.ticket_url] The url used for purchasing tickets to the event
    # @apiParam  {String} [event.place_identifier] Used for google maps API 
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
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
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
    # @api {patch} /events Update a events item
    # @apiName UpdateEvents
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiUse Params
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
    # 
    # @apiUse Success
    # 
    # 
    #*

    def update
        @event.update_attributes(event_params)
        if @event.valid?
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
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {Number} id ID of the event being deleted
    # 
    # 
    # @apiParamExample  {type} Request-Example:
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
    def events_params
        params.require(:event).permit(%i[ name description starts_at ends_at ticket_url place_identifier ])
    end
    
end
