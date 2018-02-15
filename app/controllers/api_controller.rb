class ApiController < ApplicationController
  include FloadUp

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  set_current_tenant_through_filter

  before_action :set_product

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
  def return_the(obj, opts = {})
    opts = { using: params[:action] }.merge(opts)

    #
    # If `obj` doesn't know what `valid?` means then we're presumably
    # dealing with a simple Hash or something and such things are presumably
    # okay. If `obj.destroyed?` then we're presumably responding to a
    # successful DESTROY call. The `valid?` should should take care of
    # everything else.
    #
    if obj.nil?
      render json: { errors: { base: [ _("Not found") ] } }, status: :not_found
    elsif (obj.respond_to?(:valid?) && !obj.valid?)
      render json: { errors: obj.errors.messages.values.flatten }, status: :unprocessable_entity
    elsif (!obj.respond_to?(:valid?) || obj.destroyed? || obj.valid?)
      render action: opts[:using], formats: %i[json]
    end
  end

protected

  def render_error(error)
    render json: { errors: error }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { errors: { base: [ "Not found" ] } }, status: :not_found
  end

  def set_product
    product = current_user.try(:product) || Product.find_by(internal_name: params[:product])
    if product.nil?
      render json: { errors: "You must supply a valid product" }, status: :unprocessable_entity
    else
      set_current_tenant(product)
    end
  end

  def not_authenticated
    head :unauthorized
  end
end
