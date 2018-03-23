class Api::V1::PeopleController < ApiController
  prepend_before_action :logout, only: :create

  before_action :admin_only, only: %i[ index ]

  load_up_the Person, except: %i[ index ]
  skip_before_action :require_login, only: %i[ create ]

  #**
  # @api {patch} /people/:id/change_password Change your password.
  # @apiName ChangePassword
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to change the logged in user's password.
  #
  # @apiParam {ObjectId} id
  #   The person id.
  # @apiParam {Object} person
  #   The person's information.
  # @apiParam {String} person.current_password
  #   Current password.
  # @apiParam {String} [person.new_password]
  #   New password.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok or 422
  #*
  def change_password
    if @person == current_user
      if @person.valid_password?(person_params[:current_password])
        @person.password = person_params[:new_password]
        if @person.save
          head :ok
        else
          render_error(@person.errors.full_messages)
        end
      else
        render_error("The password is incorrect")
      end
    else
      render_not_found
    end
  end

  #**
  # @api {post} /people Create person.
  # @apiName CreatePerson
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to create a new person.
  #
  #   If they account creation is successful, they will be logged in and we will send an onboarding
  #   email (if we have an email address for them).
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
  #   Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person (person json with email).
  #       ....see show action for person json...,
  #       "email" : "foo@example.com"
  #     }
  #*
  def create
    parms = person_params
    if params[:facebook_auth_token].present?
      @person = Person.create_from_facebook(params[:facebook_auth_token], parms[:username])
      if @person.nil?
        (render json: { errors: "There was a problem contacting Facebook" }, status: :service_unavailable) && return
      end
    else
      @person = Person.create(person_params)
    end
    if @person.valid?
      @person.do_auto_follows
      auto_login(@person)
      if @person.email.present?
        @person.send_onboarding_email
      end
    end
    return_the @person
  end

  #**
  # @api {get} /people Get a list of people.
  # @apiName GetPeople
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to get a list of people.
  #
  # @apiParam {String} [username_filter]
  #   A username or username fragment to filter on.
  #
  # @apiParam {String} [email_filter]
  #   An email or email fragment to filter on.

  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "people": [
  #         {...see show action for person json....},....
  #      ]
  #*
  def index
    @people = apply_filters
    return_the @people
  end

  #**
  # @api {get} /people/:id Get a person.
  # @apiName GetPerson
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to get a person.
  #
  # @apiParam {ObjectId} id
  #   The id of the person you want.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": {
  #       "id": "5016",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "picture_url": "http://host.name/path",
  #       "product_account": false,
  #       "recommended": false,
  #       "chat_banned": false,
  #       "designation": "Grand Poobah",
  #       "following_id": 12, //or null
  #       "relationships": [ {json for each relationship}], //only present if relationships present
  #       "badge_points": 0,
  #       "level": {...level json...}, //or null,
  #       "do_not_message_me": false,
  #       "pin_messages_from": false,
  #       "auto_follow": false,
  #       "facebookid": 'fadfasdfa',
  #       "facebook_picture_url": "facebook.com/zuck_you.jpg"
  #     }
  #*
  def show
    @person = Person.find(params[:id])
    return_the @person
  end

  #**
  # @api {put | patch} /people/:id Update person.
  # @apiName UpdatePerson
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to update a person. Anything not mentioned is left
  #   alone.
  #
  # @apiParam {ObjectId} id
  #   The person id.
  # @apiParam {Object} person
  #   The person's information.
  # @apiParam {String} [person.email]
  #   Email address.
  # @apiParam {String} [person.name]
  #   Full name.
  # @apiParam {String} [person.username]
  #   Username. This needs to be unique.
  # @apiParam {Attachment} [person.picture]
  #   Profile picture, this should be `image/gif`, `image/png`, or
  #   `image/jpeg`.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person.
  #       ...see create action....
  #     }
  #*
  def update
    if @person == current_user
      @person.update(person_params)
      return_the @person
    else
      render_not_found
    end
  end

private

  def apply_filters
    people = Person.all
    params.each do |p, v|
      if p.end_with?("_filter") && Person.respond_to?(p)
        people = people.send(p, v)
      end
    end
    people
  end

  def person_params
    params.require(:person).permit(:email, :facebook_auth_token, :name, :username, :password, :picture, :product, :current_password,
                                    :new_password)
  end
end
