class Api::V1::SessionController < ApiController
  skip_before_action :require_login
  skip_before_action :set_product, only: %i[ index ]

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
  #       "id": "5016cd8b30f1b95cb300004d",
  #       "email": "addr@example.com",
  #       "apns": "big-long-string",
  #       "device_id": "big-long-string",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #       "location": "Toronto, ON, Canada",
  #       "blurb": "text/html blurb",
  #       "over_13": true,  // Are they 13+ years of age?
  #       "over_18": true,  // Are they 18+ years of age?
  #       "score": 11,      // Total score on this property.
  #       "talent_id",      // id of talent containing this person (only if exists)
  #       "n_posts": 6,     // Number of posts that this person has made on this property.
  #       "n_followers": 0, // Number of people following this person.
  #       "n_following": 3, // Number of people this person is following.
  #       "n_invites": 11,  // Number of people they've invited.
  #       "is_bot": false,
  #       "is_staff": true,
  #       "subscription": {            // If there is one for the current app property (collection subs are returned with collections).
  #         "property_id": 1,
  #         "property_name": 'MusicTO',
  #         "starts_on": "2015-06-11", // When their current subscription started, ISO8601 date.
  #         "ends_on": "2016-06-11"    // When the current subscription ends, ISO8601 date.
  #       }
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
  # @apiParam {String} email
  #   The person's email address or username.
  # @apiParam {String} password
  #   The person's password.
  # @apiParam {Boolean} [keep]
  #   True if you want to keep them signed in, otherwise this will be a
  #   non-persistent session.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": {
  #       "id": "5016cd8b30f1b95cb300004d",
  #       "email": "addr@example.com",
  #       "apns": "big-long-string",
  #       "device_id": "big-long-string",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #       "location": "Toronto, ON, Canada",
  #       "blurb": "text/html blurb",
  #       "over_13": true,  // Are they 13+ years of age?
  #       "over_18": true,  // Are they 18+ years of age?
  #       "talent_id",      // id of talent containing this person (only if exists)
  #       "score": 11,      // Total score on this property.
  #       "n_posts": 6,     // Number of posts that this person has made on this property.
  #       "n_followers": 0, // Number of people following this person.
  #       "n_following": 3, // Number of people this person is following.
  #       "n_invites": 11,  // Number of people they've invited.
  #       "is_bot": false,
  #       "is_staff": true,
  #       "subscription": {            // If there is one for the current app property (collection subs are returned with collections).
  #         "property_id": 1,
  #         "property_name": 'MusicTO',
  #         "starts_on": "2015-06-11", // When their current subscription started, ISO8601 date.
  #         "ends_on": "2016-06-11"    // When the current subscription ends, ISO8601 date.
  #       }
  #     }
  #*
  def create
    #fix_booleans_in!(:keep)
    @person = login(params[:email], params[:password])
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
