module Admin
  class SessionsController < Admin::ApplicationController
    set_current_tenant_through_filter

    skip_before_action :require_login, :authenticate_admin, :set_tenant

    def create
      @person = Person.can_login_as_admin?(params[:email_or_username])
      if @person && (@person = login(@person.email, params[:password]))
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
  end
end
