class Api::V1::PeopleController < ApiController
  prepend_before_action :logout, only: :create

  skip_before_action :require_login, only: %i[ create ]

  #**
  # @api {post} /people Create person.
  # @apiName CreatePerson
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to create a new person.
  #
  #   We will log them in along the way.
  #
  # @apiParam {String} product
  #   Internal name of product
  # @apiParam {Object} person
  #   The person's information.
  # @apiParam {String} person.email
  #   Email address (required unless using FB auth token).
  # @apiParam {String} facebook_auth_token
  #   Auth token from Facebook
  # @apiParam {String} [person.name]
  #   Name.
  # @apiParam {String} person.username
  #   Username. This needs to be unique within product scope.
  # @apiParam {String} person.password
  #   Password.
  # @apiParam {Attachment } [person.picture]
  #   NOT YET SUPPORTED Profile picture, this should be `image/gif`, `image/png`, or
  #   `image/jpeg`.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person.
  #       "id": "5016",
  #       "email": "addr@example.com",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #     }
  #*
  def create
    parms = person_params
    if params[:facebook_auth_token].present?
      @person = Person.create_from_facebook(params[:facebook_auth_token], parms[:username])
      if @person.nil?
        render json: { errors: "There was a problem contacting Facebook" }, status: :service_unavailable && return
      end
    else
      @person = Person.create(person_params)
    end
    if @person.valid?
      auto_login(@person)
    end
    return_the @person
  end

  def person_params
    params.permit(:email, :facebook_auth_token, :name, :username, :password, :picture, :product)
  end
end
