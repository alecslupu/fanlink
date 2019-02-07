module JSONErrors
  extend ActiveSupport::Concern
  included do
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_error
      rescue_from ActiveRecord::RecordNotFound,         with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,          with: :unprocessable_entity
      rescue_from ActionController::RoutingError,       with: :render_not_found
      rescue_from ActionController::UnknownController,  with: :render_not_found
      rescue_from Pundit::NotAuthorizedError,           with: :user_not_authorized
      rescue_from ActionController::UnknownFormat,      with: :render_not_found
    end
  end

  # Called by last route matching unmatched routes
  # Raises RoutingError which will be rescued from in the same way as other exceptions.
  def raise_not_found!
    render nothing: true and return if params[:path] && params[:path] =~ /\A(assets|uploads|images)/
    raise ActionController::RoutingError.new("No route matches #{params[:path]}")
  end

  private

  def render_not_found(exception)
    render_exception exception, code: 404, message: 'Not Found Error'
  end
  def render_404(errors = "not found")
    return
    # render json: { errors: "Not found." }, status: :not_found
  end

  def render_422(errors = "could not save data")
    return
    # errors = errors.messages.values.flatten if errors.instance_of? ActiveModel::Errors
    # errors = Array.wrap(errors) unless errors.is_a?(Array)
    # render json: { errors: errors }, status: 422

  def unprocessable_entity(exception)
    message = exception.messages.values.flatten if exception.instance_of? ActiveModel::Errors
    message ||= "Unable to process your request."
    render_exception exception, code: 422, message: message
  end

  def render_error(exception)
    render_exception exception, code: 500, message: ['Server Error']
  end

  def user_not_authorized(exception)
    render_exception exception, code: 403, message: ['Not Authorized']
  end

  def render_exception(exception, opts = {})
    Rails.logger.error exception.message
    Rails.logger.error exception.backtrace.join("\n")
    level = case opts[:code]
            when 401, 403
            "info"
            when 404
              "warning"
            when 422
              "debug"
            when 500
              "critical"
            else
              "error"
    end
    Rollbar.log(level, exception)
    opts[:message] = Array.wrap(opts[:message]) unless opt[:message].is_a?(Array)
    render json: { errors: opts[:message] }, status: opts[:code]
  end
end
