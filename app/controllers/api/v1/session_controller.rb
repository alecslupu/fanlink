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
  #   The person's email address or username.
  # @apiParam {String} password
  #   The person's password.
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
    #fix_booleans_in!(:keep)
    @person = Person.can_login?(params[:email_or_username])
    @person = login(@person.email, params[:password]) if @person
    if !@person
      return render json: { errors: [ "Invalid login." ] , status: :unprocessable_entity }
    elsif @person.errors.present?
      return render json: { errors: @person.errors.values.flatten }, status: :unprocessable_entity
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
