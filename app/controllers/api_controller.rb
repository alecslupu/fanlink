class ApiController < ApplicationController

  #
  # Respond to an API request with an object. If the object is invalid
  # (i.e. responds to `valid?` and `valid?` is false) then we will send
  # back `{ :errors => obj.errors }` in JSON with a 402 response code;
  # otherwise we will respond by rendering the current action's view.
  #
  # You can use the `:using` option to specify a different action. A common
  # use would be something like this:
  #
  #     return_the @thing, :using => :show
  #
  # This is a homebrew replacement for `respond_with` which disappeared
  # in Rails4.
  #
  # @param [Object] obj
  #   The object to respond with.
  # @param [Hash] opts
  #   Options. We currently only have a `:using` option that defaults
  #   to the current `params[:action]` value.
  #
  def return_the(obj, opts = { })
    opts = { :using => params[:action] }.merge(opts)

    #
    # If `obj` doesn't know what `valid?` means then we're presumably
    # dealing with a simple Hash or something and such things are presumably
    # okay. If `obj.destroyed?` then we're presumably responding to a
    # successful DESTROY call. The `valid?` should should take care of
    # everything else.
    #
    if(obj.nil?)
      render :json => { :errors => { :base => [ _('Not found') ] } }, :status => :not_found
    elsif(obj.respond_to?(:valid?) && !obj.valid?)
      render :json => { :errors => obj.errors }, :status => :unprocessable_entity
    elsif(!obj.respond_to?(:valid?) || obj.destroyed? || obj.valid?)
      render :action => opts[:using], :formats => %i[json]
    else
      render :json => { :errors => obj.errors }, :status => :unprocessable_entity
    end
  end

  private

  def set_default_request_format
    request.format = :json
  end


end
