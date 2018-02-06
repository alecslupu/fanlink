module Admin
  class SessionsController < Admin::ApplicationController
    set_current_tenant_through_filter

    skip_before_action :require_login, :check_admin, :set_tenant

    def create
      product = nil
      if params[:product_internal_name].present?
        product = Product.find_by(internal_name: params[:product_internal_name])
        set_current_tenant(product)
      end
      if product.present?
        email  = params[:email_or_username].to_s
        query  = email.include?('@') ? { email: email.strip.downcase } : { username_canonical: Person.canonicalize(email) }
        person = Person.find_by(query)
        person = login(person.email, params[:password]) if person
        if person
          check_admin
          redirect_to admin_people_path unless performed?
        else
          flash[:alert] = "Login failed"
          redirect_to admin_path(product_internal_name: product.internal_name)
        end
      else
        head :not_found
      end
    end

    def destroy
      if current_user
        product = current_user.product
        logout
        redirect_to(admin_path(product_internal_name: product.internal_name), notice: "Logged out!")
      end
    end

    def new
      logout
      @product = nil
      if params[:product_internal_name].present?
        @product = Product.find_by(internal_name: params[:product_internal_name])
      end
      if @product.nil?
        head :not_found
      else
        @person = Person.new
      end
    end
  end
end
