class RailsAdminController < ApplicationController
  def not_authenticated
    # Make sure that we reference the route from the main app.
    redirect_to '/admin/admin/login' and return
  end

  def require_login
    unless logged_in?
      session[:return_to_url] = '/admin_portal/'
      send(Config.not_authenticated_action)
    else
      not_found unless current_user.product_id == Product.first.id && current_user.role == 'super_admin'
    end
  end

  private
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
