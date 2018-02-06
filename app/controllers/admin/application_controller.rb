# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    set_current_tenant_through_filter
    before_action :require_login, :check_admin, :set_tenant

  # Override this value to specify the number of elements to display at a time
  # on index pages. Defaults to 20.
  # def records_per_page
  #   params[:per_page] || 20
  # end

  protected

    def check_admin
      not_authenticated unless (current_user.super_admin? || current_user.some_admin?)
    end

    def check_super
      not_authenticated unless current_user.super_admin?
    end

    def not_authenticated
      redirect_to admin_login_path, notice: "Login required."
    end

    def set_tenant
      product = nil
      if params[:product_internal_name].present?
        product = Product.find_by(internal_name: params[:product_internal_name])
      else
        if current_user.super_admin?
          product = Product.find(cookies[:product_id])
        else
          product = current_user.product
        end
      end
      if product.present?
        set_current_tenant(product)
      else
        head :not_found
      end
    end
  end
end
