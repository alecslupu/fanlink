# frozen_string_literal: true

module Api
  module V1
    class PeopleController < ApiController
      # TODO: Lock down GET /people to admin only or something.
      prepend_before_action :logout, only: :create

      load_up_the Person, except: %i[index]
      skip_before_action :require_login, only: %i[create]

      # **
      # @api {patch} /people/:id/change_password Change your password.
      # @apiName ChangePassword
      # @apiGroup People
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This is used to change the logged in user's password.
      #
      # @apiParam (path) {Object} id
      #   The person id.
      # @apiParam (body) {Object} person
      #   The person's information.
      # @apiParam (body) {String} person.current_password
      #   Current password.
      # @apiParam (body) {String} [person.new_password]
      #   New password.
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok or 422
      # *

      def change_password
        if @person == current_user
          if @person.valid_password?(person_params[:current_password])
            if person_params[:current_password] == person_params[:new_password]
              render_error(_("New password can't be identical to your current one"))
            else
              @person.password = person_params[:new_password]
              if @person.save
                head :ok
              else
                render_error(@person.errors)
              end
            end
          else
            render_error(_('The password is incorrect'))
          end
        else
          render_not_found
        end
      end

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
          render_error(_("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}"))
        else
          parms = person_params
          if params[:facebook_auth_token].present?
            @person = Person.create_from_facebook(params[:facebook_auth_token], parms[:username])
            if @person.nil?
              (render json: { errors: 'There was a problem contacting Facebook' }, status: :service_unavailable) && return
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
        @person = Person.find(params[:id])
        return_the @person
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
        if !check_gender
          render_error(_("Gender is not valid. Valid genders: #{Person.genders.keys.join('/')}"))
        else
          if @person == current_user || current_user.admin? || current_user.product_account
            @person.trigger_admin = true
            @person.update(person_params)
            return_the @person
          else
            render_not_found
          end
        end
      end

      protected

      def apply_filters
        people = Person.order(created_at: :desc)
        params.each do |p, v|
          if p.end_with?('_filter') && Person.respond_to?(p)
            people = people.send(p, v, current_user)
          end
        end
        people
      end

      def check_gender
        params[:person][:gender].nil? || Person.genders.keys.include?(params[:person][:gender])
      end

      private

      def person_params
        params.require(:person).permit(%i[ email facebook_auth_token name gender birthdate biography city country_code
                                           username password picture product current_password new_password ] +
                                         ((current_user.present? && (current_user.admin? || current_user.product_account)) ? %i[recommended] : []))
      end
    end
  end
end
