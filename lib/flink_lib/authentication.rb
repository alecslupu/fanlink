module FlinkLib
  module Authentication
    def self.included(base)
      base.class_exec do
        def self.acts_as_auth
          helper_method :logged_in?, :current_user
          hide_action   :logged_in?, :current_user, :authenticate_flink_user_id
        end

        def self.person_class
          Person
        end
      end
    end

    def authenticate_flink
      return bad_person(:not_logged_in)     if !logged_in?
      return bad_person(:suspended_account) if current_user.suspended?
      true
    end

    def current_user
      if !@current_user && session[:user_id]
        @current_user = self.class.person_class.find(session[:user_id])
      elsif !session[:user_id]
        @current_user = nil
      end
      @current_user
    end

    def logged_in?
      !!current_user
    end

    def logout_session
      reset_session
      current_user = nil
      cookies.clear
    end

    private

      def bad_person(reason)
        render json: { not_logged_in: true, reason: reason }, status: :forbidden
        logout_session
        false
      end
  end
end
