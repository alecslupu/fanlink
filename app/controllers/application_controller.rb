class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :require_login

  def status
    head :ok
  end
  skip_before_action :require_login, only: %i[ status ]

  protected
    def require_login
      authenticate!
      super
    end

    def authenticate!
      return if authorization_header.nil?
      payload, header = TokenProvider.valid?(token)
      user = Person.find_by(id: payload["user_id"])
      auto_login(user) unless user.nil? || user.terminated?
    rescue JWT::DecodeError
    end

    def token
      @jwt_token ||= (authorization_header.split(" ").last)
    end

  private

    def authorization_header
      request.headers["Authorization"]
    end
end
