class Api::V1::SessionController < ApiController
  prepend_before_action :logout, only: :create
  skip_before_action :require_login
  skip_before_action :set_product, except: %i[ create ]

  #**
  # @api {get} /session Check a session.
  # @apiName GetSession
  # @apiGroup Sessions
  #
  # @apiDescription
  #   This is used to see if your current session is valid. We return the
  #   currently logged-in person if the session is still good and a 404
  #   otherwise.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": {
  #       "id": "5016",
  #       "email": "addr@example.com",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #     }
  #
  # @apiErrorExample {json} Error-Response:
  #     HTTP/1.1 404 Not Found
  #*
  def index
    if @person = current_user
      return_the @person
    else
      render body: nil, status: :not_found
    end
  end

  #**
  # @api {post} /session Log someone in.
  # @apiName CreateSession
  # @apiGroup Sessions
  #
  # @apiDescription
  #   This is used to log someone in.
  #
  # @apiParam {String} product
  #  Internal name of product logging into.
  # @apiParam {String} email_or_username
  #   The person's email address or username. Required unless using Facebook ID.
  # @apiParam {String} [facebook_auth_token]
  #   The facebook auth token. Required unless using username/password.
  # @apiParam {String} password
  #   The person's password. Required unless using facebook_auth_token
  # @apiParam {Boolean} [keep] NOT YET SUPPORTED
  #   True if you want to keep them signed in, otherwise this will be a
  #   non-persistent session.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": {
  #       "id": "5016",
  #       "email": "addr@example.com",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #     }
  #*
  def create
    @person = nil
    #fix_booleans_in!(:keep)
    if params["facebook_auth_token"].present?
      @person = Person.for_facebook_auth_token(params["facebook_auth_token"])
      return render json: { errors: [ "Unable to find user from token. Likely a problem contacting Facebook."] }, status: :service_unavailable if @person.nil?
      auto_login(@person)
    else
      @person = Person.can_login?(params[:email_or_username])
      @person = login(@person.email, params[:password], true) if @person
      return render json: { errors: [ "Invalid login." ] }, status: :unprocessable_entity  if @person.nil?
    end
    #bake_cookies_for(@person)
    return_the @person
  end

  #**
  # @api {delete} /session Log someone out.
  # @apiName DestroySession
  # @apiGroup Sessions
  #
  # @apiDescription
  #   This is used to log someone out.
  #*
  def destroy
    logout
    render body: nil, status: :ok
  end

  private

  # def bake_cookies_for(person)  #,,,refactor: this method has been copied here and there
  #   return if(!person || !person.valid?)
  #   session[:keep] = params[:keep]
  #   cookie = { :value => 1 }
  #   cookie[:expires] = 2.years.from_now if(params[:keep])
  #   cookies[:logged] = cookie
  # end
end
