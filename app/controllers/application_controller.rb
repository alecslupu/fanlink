class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  #
  # Authentication by default, use `doesnt_need_to_be_signed_in_to` if
  # you don't want it somewhere.
  #
  before_action :require_login
end
