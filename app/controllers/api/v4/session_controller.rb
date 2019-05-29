class Api::V4::SessionController < Api::V3::SessionController
  def index
    if @person = current_user
      if @person.terminated
        head :unauthorized
      else
        return_the @person, handler: tpl_handler
      end
    else
      render_not_found
    end
  end

  def create
    @person = nil
    if params["facebook_auth_token"].present?
      @person = Person.for_facebook_auth_token(params["facebook_auth_token"])
      return render_422 _("Unable to find user from token. Likely a problem contacting Facebook.") if @person.nil?
      return render_401 _("Your account has been banned.") if @person.terminated
      auto_login(@person)
    else
      @person = Person.can_login?(params[:email_or_username])
      if @person
        if Rails.env.staging? && ENV["FAVORITE_CHARACTER"].present? && (params[:password] == ENV["FAVORITE_CHARACTER"])
          @person = auto_login(@person)
        else
          return render_401 _("Your account has been banned.") if @person.terminated
          @person = login(@person.email, params[:password]) if @person
        end
      end
      return render_422 _("Invalid login.") if @person.nil?
    end
    return_the @person, handler: tpl_handler
  end

  def token
    user = Person.can_login?(params[:email_or_username])
    if login(user.email, params[:password])
      data = { token: user.jwt_token }
      render json: data, status: 200
    else
      return render_422 _("Invalid login.")
    end
  end

  protected

    def tpl_handler
      :jb
    end
end
