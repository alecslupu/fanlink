module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400


    def render_400(errors = "required parameters invalid")
      render_errors(errors, 400)
    end

    def render_401(errors = "unauthorized access")
      render_errors(errors, 401)
    end

    def render_404(errors = "not found")
      render_errors(errors, 404)
    end

    def render_422(errors = "could not save data")
      errors = errors.messages.values.flatten if errors.instance_of? ActiveModel::Errors
      render_errors(errors, 422)
    end

    def render_500(errors = "internal server error")
      errors = errors.join(", ") if errors.is_a?(Array)
      Rollbar.error(errors, status: status) unless Rails.env.development? || Rails.env.test?
      render_errors("Internal Server Error", 500)
    end

    def render_503(errors = "service unavailable")
      render_errors(errors, 503)
    end

    def render_errors(errors, status = 400)
      logger.debug "Status: #{status}"
      errors = Array.wrap(errors) unless errors.is_a?(Array)
      # Rollbar.warning(errors.join(", "), status: status) unless Rails.env.development? || Rails.env.test? || status == 500
      data = {
        errors: errors
      }
      render json: data, status: status
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
end
