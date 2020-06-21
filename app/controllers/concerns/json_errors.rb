# frozen_string_literal: true

module JSONErrors
  extend ActiveSupport::Concern
  # set_trace_func proc { |event, file, line, id, proc_binding, classname|
  #   if !$pried && proc_binding && proc_binding.eval( "caller.size" ) > 200
  #     $pried = true
  #     proc_binding.pry
  #   end
  # }
  included do
    # rescue_from SystemStackError                    with: :output_tracelog
    rescue_from StandardError,                      with: :render_500
    rescue_from NameError,                          with: :render_500
    rescue_from ActiveRecord::RecordInvalid,        with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400
    rescue_from ActionController::RoutingError,     with: :render_404
#    rescue_from Rack::Timeout::RequestTimeoutException, with: :render_500
    rescue_from AccessDeniedException, with: :render_401
  end

  def render_400(errors = "required parameters invalid")
    render_errors(errors, 400)
  end

  def render_401(errors = "unauthorized access")
    errors = errors.message if errors.is_a?(AccessDeniedException)

    render_errors(errors, 401)
  end

  def render_404(errors = "not found")
    render json: { errors: "Not found." }, status: :not_found
  end

  def render_422(errors = "could not save data")
    errors = errors.messages.values.flatten if errors.instance_of? ActiveModel::Errors
    render_errors(errors, 422)
  end

  # Will be used once the alls to all the render_422 method are removed from the controllers
  def unprocessable_entity(exception)
    render json: { errors: exception.record.errors.messages.values.flatten }, status: :unprocessable_entity
    nil
  end

  def render_500(errors)
    unless (Rails.env.test? && ENV["ROLLBAR_ENABLED"])
      logger.error ActiveSupport::LogSubscriber.new.send(:color, errors, :yellow)
      errors.backtrace.each { |line| logger.error ActiveSupport::LogSubscriber.new.send(:color, line, :red) }  unless errors.is_a?(String)
    end
    render json: { errors: errors.message }.to_json, status: 500
    nil
  end

  def render_503(errors = "service unavailable")
    render_errors(errors, 503)
  end

  def render_errors(errors, status = 400)
    errors = Array.wrap(errors) unless errors.is_a?(Array)
    # if status == 500
    #   # logger.error ActiveSupport::LogSubscriber.new.send(:color, errors, :yellow) unless Rails.env.test?
    #   # errors.backtrace.each { |line| logger.error ActiveSupport::LogSubscriber.new.send(:color, line, :red) } unless Rails.env.test?
    #   # Rollbar.error(errors.join(", "), status: status) unless Rails.env.development? || Rails.env.test?
    # else
    #   # logger.warn ActiveSupport::LogSubscriber.new.send(:color, errors, :yellow)  unless Rails.env.test?
    #   # Rollbar.warning(errors.join(", "), status: status) unless Rails.env.development? || Rails.env.test?
    # end
    data = {
      errors: errors
    }
    render json: data, status: status
    nil
  end


  def render_object_errors(obj, status = 400)
    if obj.is_a?(ActiveRecord::Base) # ActiveModel::Model for Mongoid
      render_object_errors(obj.errors, status)
    elsif obj.is_a?(ActiveModel::Errors)
      render_errors(obj.full_messages, status)
    else
      render_errors(obj, status)
    end
  end
end
