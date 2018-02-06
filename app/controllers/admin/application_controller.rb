# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    set_current_tenant_through_filter
    before_action :require_login, :authenticate_admin, :set_tenant

    def authenticate_admin
      not_authenticated unless current_user && current_user.some_admin?
    end

  # Override this value to specify the number of elements to display at a time
  # on index pages. Defaults to 20.
  # def records_per_page
  #   params[:per_page] || 20
  # end

  protected

    def check_super
      not_authenticated unless current_user.super_admin?
    end

    def not_authenticated
      redirect_to admin_login_path, notice: "Login required."
    end

    def set_tenant
      if current_user
        if current_user.super_admin?
          if cookies[:product_id].present?
            set_current_tenant(Product.find(cookies[:product_id]))
          else
            redirect_to select_form_admin_products_path
          end
        else
          set_current_tenant(current_user.product)
        end
      end
    end
  end
end
