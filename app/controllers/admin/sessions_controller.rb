module Admin
  class SessionsController < ::ApplicationController
    set_current_tenant_through_filter
    skip_before_action :require_login
    layout 'admin'

    def create
      product = nil
      if params[:product_internal_name].present?
        product = Product.find_by(internal_name: params[:product_internal_name])
        set_current_tenant(product)
      end
      if product.present?
        email  = params[:email_or_username].to_s
        query  = email.include?("@") ? { email: email.strip.downcase } : { username_canonical: Person.canonicalize(email) }
        person = Person.find_by(query)
        person = login(person.email, params[:password]) if person
        if person
          check_admin
          redirect_to rails_admin_path unless performed?
        else
          flash[:alert] = "Login failed"
          redirect_to admin_login_screen_path(product_internal_name: product.internal_name)
        end
      else
        head :not_found
      end
    end

    def destroy
      if current_user
        product = current_user.product
        logout
        redirect_to(admin_login_screen_path(product_internal_name: product.internal_name), notice: "Logged out!")
      end
    end

    def login_redirect
      if product = Product.find_by(internal_name: params[:product_internal_name])
        redirect_to(admin_login_screen_path(product_internal_name: product.internal_name))
      else
        render_not_found
      end
    end

    def new
      @product = nil
      if params[:product_internal_name].present?
        @product = Product.find_by(internal_name: params[:product_internal_name])
      end
      if @product.nil?
        head :not_found
      else
        @person = Person.new
      end
      redirect_to(rails_admin.dashboard_path) && return if current_user.present?
    end

    protected

    def not_authenticated
      logout
      if params[:product_internal_name].present?
        redirect_to admin_path(product_internal_name: params[:product_internal_name]), notice: "Login required."
      elsif cookies[:product_internal_name].present?
        redirect_to admin_path(product_internal_name: cookies[:product_internal_name]), notice: "Login required."
      else
        render_not_found
      end
    end

    def render_not_found
      render file: "public/404.html", status: :not_found, layout: false
    end

    def check_admin
      not_authenticated if %w[normal client].include?(current_user.assigned_role.internal_name)
    end
  end
end
