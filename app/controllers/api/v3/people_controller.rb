# frozen_string_literal: true

class Api::V3::PeopleController < Api::V2::PeopleController
  prepend_before_action :logout, only: :create
  before_action :super_admin_only, only: %i[ destroy ]
  load_up_the Person, except: %i[ index create ]
  skip_before_action :require_login, only: %i[ create ]
  skip_before_action :require_login, :set_product, only: %i[ public ]

  # **
  # @api {post} /people Create person.
  # @apiName CreatePerson
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to create a new person.
  #
  #   If the account creation is successful, they will be logged in and we will send an onboarding
  #   email (if we have an email address for them).
  #
  # @apiParam (body) {String} product
  #   Internal name of product
  #
  # @apiParam (body) {Object} person
  #   The person's information.
  #
  # @apiParam (body) {String} person.email
  #   Email address (required unless using FB auth token).
  #
  # @apiParam (body) {String} facebook_auth_token
  #   Auth token from Facebook
  #
  # @apiParam (body) {String} [person.name]
  #   Name.
  #
  # @apiParam (body) {String} person.username
  #   Username. This needs to be unique within product scope.
  #
  # @apiParam (body) {String} person.password
  #   Password.
  #
  # @apiParam (body) {Attachment} [person.picture]
  #   Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`.
  #
  # @apiParam (body) {String} [person.gender]
  #   Gender. Valid options: unspecified (default), male, female
  #
  # @apiParam (body) {String} [person.birthdate]
  #   Birth dateTo date in format "YYYY-MM-DD".
  #
  # @apiParam (body) {String} [person.city]
  #   Person's supplied city.
  #
  # @apiParam (body) {String} [person.country_code]
  #   Alpha2 code (two letters) from ISO 3166 list.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person (person json with email).
  #       ....see show action for person json...,
  #       "email" : "foo@example.com"
  #     }
  # *

  def create
    if !check_gender
      render_error("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
    else
      parms = person_params
      if params[:facebook_auth_token].present?
        @person = Person.create_from_facebook(params[:facebook_auth_token], parms[:username])
        if @person.nil?
          (render json: { errors: _("There was a problem contacting Facebook.") }, status: :service_unavailable) && return
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
        return_the @person
      else
        render_422 @person.errors
      end
    end
  end

  # **
  # @api {get} /people Get a list of people.
  # @apiName GetPeople
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to get a list of people.
  #
  # @apiParam (query) {Integer} [page]
  #   Page number to get. Default is 1.
  #
  # @apiParam (query) {Integer} [per_page]
  #   Page division. Default is 25.
  #
  # @apiParam (query) {String} [username_filter]
  #   A username or username fragment to filter on.
  #
  # @apiParam (query) {String} [email_filter]
  #   An email or email fragment to filter on.

  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "people": [
  #         {...see show action for person json....},....
  #      ]
  # *

  def index
    @people = paginate apply_filters
    @people = @people.reject { |person| person == current_user }
    return_the @people
  end

  # **
  # @api {get} /people/:id Get a person.
  # @apiName GetPerson
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to get a person.
  #
  # @apiParam (path) {Number} id
  #   The id of the person you want.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": {
  #       "id": "5016",
  #       "username": "Pancakes.McGee",
  #       "name": "Pancakes McGee",
  #       "gender": "unspecified",
  #       "city": "Neverland",
  #       "country_code": "US",
  #       "birthdate": null,
  #       "picture_url": "http://host.name/path",
  #       "product_account": false,
  #       "recommended": false,
  #       "chat_banned": false,
  #       "designation": "Grand Poobah",
  #       "following_id": 12, //or null
  #       "relationships": [ {json for each relationship}], //only present if relationships present
  #       "badge_points": 0,
  #       "role": "normal",
  #       "level": {...level json...}, //or null,
  #       "do_not_message_me": false,
  #       "pin_messages_from": false,
  #       "auto_follow": false,
  #       "num_followers": 0,
  #       "num_following": 0,
  #       "facebookid": 'fadfasdfa',
  #       "facebook_picture_url": "facebook.com/zuck_you.jpg"
  #       "created_at": "2018-03-12T18:55:30Z",
  #       "updated_at": "2018-03-12T18:55:30Z"
  #     }
  # *

  def show
    if current_user.blocks_by.where(blocked_id: params[:id]).exists?
      render_not_found
    else
      @person = Person.find(params[:id])
      return_the @person
    end
  end

  def public
    @person = Person.find(params[:id])
    return_the @person, handler: "jb"
  end

  # **
  # @api {put | patch} /people/:id Update person.
  # @apiName UpdatePerson
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to update a person. Anything not mentioned is left
  #   alone.
  #
  # @apiParam (path) {Number} id
  #   The person id.
  # @apiParam (body) {Object} person
  #   The person's information.
  # @apiParam (body) {String} [person.email]
  #   Email address.
  # @apiParam (body) {String} [person.name]
  #   Full name.
  #
  # @apiParam (body) {String} [person.username]
  #   Username. This needs to be unique.
  # @apiParam (body) {Attachment} [person.picture]
  #   Profile picture, this should be `image/gif`, `image/png`, or
  #   `image/jpeg`.
  #
  # @apiParam (body) {String} [person.gender]
  #   Gender. Valid options: unspecified (default), male, female
  #
  # @apiParam (body) {String} [person.birthdate]
  #   Birth dateTo date in format "YYYY-MM-DD".
  #
  # @apiParam (body) {String} [person.city]
  #   Person's supplied city.
  #
  # @apiParam (body) {String} [person.country_code]
  #   Alpha2 code (two letters) from ISO 3166 list.
  #
  # @apiParam (body) {Boolean} [recommended]
  #   Whether this is a recommended persion. (Admin or product account only)
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "person": { // The full private version of the person.
  #       ...see create action....
  #     }
  # *

  def update
    Rails.logger.info(@person.inspect)
    if params.has_key?(:person)
      if !check_gender
        render_422("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}")
      else
        if @person == current_user || some_admin? || current_user.product_account
          if person_params.has_key?(:terminated) && @person.some_admin?
            return render_422 _("You cannot ban administative accounts.")
          end
          @person.trigger_admin = true
          @person.update(person_params)
          if @person.terminated && @person == current_user
            logout
            cookies.delete :_fanlink_session
            return render_401 _("Your account has been banned.")
          else
            return_the @person
          end
        else
          render_not_found
        end
      end
    else
      return_the @person
    end
  end

  def destroy
    if current_user.super_admin?
      @person = Person.find(params[:id])
      @person.destroy
      head :ok
    elsif some_admin?
      @person.update(deleted: true)
      head :ok
    else
      render_not_found
    end
  end

  def interests
    return_the @person
  end

private

  def person_params
    params.require(:person).permit(%i[email facebook_auth_token name gender birthdate biography city country_code
                                      username password picture product current_password new_password do_not_message_me ] +
                                   ((current_user.present? && (current_user.admin? || current_user.product_account)) ? %i[ recommended pin_messages_from auto_follow ] : []) +
                                   ((current_user.present? && some_admin?) ? %i[ chat_banned role tester product_account designation terminated terminated_reason ] : []))
  end
end
