class ApidocsController < ActionController::Base
  #before_action :require_login

  def index
    render layout: false
  end

end
