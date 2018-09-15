class ApiController < ApplicationController
  include FloadUp
  include Rails::Pagination
  include Wisper::Publisher
  include JSONErrors
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  set_current_tenant_through_filter

  before_action :set_language, :set_product, :set_paper_trail_whodunnit, :set_person, :set_app
  after_action :unset_person, :unset_app

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
    opts = { using: params[:action], handler: "jbuilder" }.merge(opts)

    #
    # If `obj` doesn't know what `valid?` means then we're presumably
    # dealing with a simple Hash or something and such things are presumably
    # okay. If `obj.destroyed?` then we're presumably responding to a
    # successful DESTROY call. The `valid?` should should take care of
    # everything else.
    #
    if obj.nil?
      render_404(_("Not found."))
    elsif (obj.respond_to?(:valid?) && !obj.valid?)
      render_422(obj.errors)
    elsif (!obj.respond_to?(:valid?) || obj.destroyed? || obj.valid?)
      render action: opts[:using], formats: %i[json], handlers: opts[:handler]
    end
  end

protected

  def admin_only
    head :unauthorized unless current_user.some_admin?
  end

  def super_admin_only
    head :unauthorized unless current_user.role == "super_admin"
  end

  def check_dates(required = false)
    if params[:from_date].present?
      return false unless DateUtil.valid_date_string?(params[:from_date])
    else
      return false if required
    end
    if params[:to_date].present?
      return false unless DateUtil.valid_date_string?(params[:to_date])
    else
      return false if required
    end
    true
  end

  def render_error(error)
    render_422(error)
  end

  def render_not_found
    render_404("Not found.")
  end

  def set_language
    @lang = nil
    lang_header = request.headers["Accept-Language"]
    if lang_header.present?
      if lang_header.length > 2
        lang_header = lang_header[0..1]
      end
      @lang = lang_header if TranslationThings::LANGS[lang_header].present?
    end
    @lang = TranslationThings::DEFAULT_READ_LANG if @lang.nil?
  end

  def set_product
    product = nil
    if current_user.present?
      if current_user.super_admin?
        if request.headers["X-Current-Product"].present?
          product = Product.find_by(internal_name: request.headers["X-Current-Product"])
        else
          if params[:product]
            product = Product.find_by(internal_name: params[:product])
          end
          product = current_user.try(:product) if product.nil?
        end
      end
    end
    product = (current_user.present? && current_user.try(:product)) || Product.find_by(internal_name: params[:product]) if product.nil?
    if product.nil?
      render json: { errors: "You must supply a valid product" }, status: :unprocessable_entity
    else
      set_current_tenant(product)
      cookies[:product_internal_name] = ((current_user.present?) ? current_user.product.internal_name : product.internal_name)
    end
  end

  def not_authenticated
    head :unauthorized
  end

  def set_person
    if current_user.present?
      Person.current_user = current_user
    end
  end

  def unset_person
    Person.current_user = nil
  end

  def set_app
    if request.headers["X-App"].present?
      @req_source = request.headers["X-App"]
    elsif params[:app].present?
      @req_source = params[:app]
    else
      @req_source = "mobile"
    end
    puts "Source: #{@req_source}"
  end

  def unset_app
    @req_source = nil
  end

  # def set_chewy_filter
  #   Chewy.settings = {prefix: ActsAsTenant.current_tenant.internal_name}
  # end
end
