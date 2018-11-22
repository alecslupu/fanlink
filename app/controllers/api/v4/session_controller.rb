class Api::V4::SessionController < Api::V3::SessionController
  def index
    if @person = current_user
      if @person.terminated
        return head :unauthorized
      else
        return_the @person, handler: 'jb'
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
    return_the @person, handler: 'jb'
  end
end
