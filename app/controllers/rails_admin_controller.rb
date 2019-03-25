class RailsAdminController < ApplicationController
  def not_authenticated
    # Make sure that we reference the route from the main app.
    redirect_to '/admin/admin/login' and return 
  end
end
