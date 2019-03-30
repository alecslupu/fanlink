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
    begin
      payload, header = TokenProvider.valid?(token)
      user = Person.find_by(id: payload['user_id'])
      auto_login(user) unless user.terminated?
    end
  end

  def token
    @jwt_token ||= request.headers['Authorization'].split(' ').last
  end
end
