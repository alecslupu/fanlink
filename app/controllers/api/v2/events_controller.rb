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
    # 
    # @api {post} /events Create a events item
    # @apiName CreateEvents
    # @apiGroup Events
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {String} paramName description
    # 
    # @apiSuccess (200) {type} name description
    # 
    # @apiParamExample  {type} Request-Example:
    # {
    #     property : value
    # }
    # 
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
    # @apiParam  {String} paramName description
    # 
    # @apiSuccess (200) {type} name description
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
    # @api {destroy} /events Destroy events
    # @apiName DestroyMerchandsie
    # @apiGroup group
    # @apiVersion  2.0.0
    # 
    # 
    # @apiParam  {String} paramName description
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
        params.require(:event).permit()
    end
    
end
