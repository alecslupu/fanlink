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
      if cookies[:product_internal_name].present?
        redirect_to admin_path(product_internal_name: cookies[:product_internal_name]), notice: "Login required."
      else
        render_not_found
      end
    end

    def render_not_found
      render file: "public/404.html", status: :not_found, layout: false
    end

    def set_tenant
      product = nil
      if params[:product_internal_name].present?
        product = Product.find_by(internal_name: params[:product_internal_name])
      else
        if current_user.super_admin? && (cookies[:product_id].to_i > 0)
          product = Product.find(cookies[:product_id])
        else
          product = current_user.product
        end
      end
      if product.present?
        set_current_tenant(product)
        cookies[:product_internal_name] = ((current_user.present?) ? current_user.product.internal_name : product.internal_name)
      else
        head :not_found
      end
    end
  end
end
