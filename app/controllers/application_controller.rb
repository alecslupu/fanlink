class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  before_action :require_login

  def status
    head :ok
  end
  skip_before_action :require_login, only: %i[ status ]
end
