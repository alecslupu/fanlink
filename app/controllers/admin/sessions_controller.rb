module Admin
  class SessionsController < Admin::ApplicationController
    set_current_tenant_through_filter

    before_action :set_product
    skip_before_action :require_login, except: %i[ destroy ]

    def create
      if @person = login(params[:email], params[:password])
        redirect_back_or_to(admin_root_path, notice: "Login successful")
      else
        flash.now[:alert] = "Login failed"
        render action: "new"
      end
    end

    def destroy
      logout
      redirect_to(admin_login_path, notice: "Logged out!")
    end

    def new
      @person = Person.new
    end

    private

      def set_product
        product = Product.find_by(subdomain: "admin")
        set_current_tenant(product)
      end
  end
end
