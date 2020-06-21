# frozen_string_literal: true


module Api
  module V1
    class SessionController < ApiController
      prepend_before_action :logout, only: :create
      skip_before_action :require_login, :check_banned
      skip_before_action :set_product, except: %i[create]

      # **
      # @api {get} /session Check a session.
      # @apiName GetSession
      # @apiGroup Sessions
      # @apiVersion 1.0.0
      #
      # @apiDescription
      # This is used to see if your current session is valid. We return the
      # currently logged-in person if the session is still good and a 404
      # otherwise.
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
      # *

      def index
        if @person = current_user
          if @person.terminated
            head :unauthorized
          else
            return_the @person
          end
        else
          render_not_found
        end
      end

      # **
      # @api {post} /session Log someone in.
      # @apiName CreateSession
      # @apiGroup Sessions
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This is used to log someone in.
      #
      # @apiParam (body) {String} product
      #  Internal name of product logging into.
      # @apiParam (body) {String} email_or_username
      #   The person's email address or username. Required unless using Facebook ID.
      # @apiParam (body) {String} [facebook_auth_token]
      #   The facebook auth token. Required unless using username/password.
      # @apiParam (body) {String} password
      #   The person's password. Required unless using facebook_auth_token
      # @apiParam (body) {Boolean} [keep] NOT YET SUPPORTED
      #   True if you want to keep them signed in, otherwise this will be a
      #   non-persistent session.
      #
      # @apiSuccessExample {json} Success-Response:
      #     HTTP/1.1 200 Ok
      #     "person": {
      #       "email": "addr@example.com",
      #       ...see person get for the rest of the fields...
      #     }
      # *

      def create
        @person = nil
        if params['facebook_auth_token'].present?
          @person = Person.for_facebook_auth_token(params['facebook_auth_token'])
          if @person.nil?
            render_503(_('Unable to find user from token. Likely a problem contacting Facebook.'))
            return
          end
          @person = auto_login(@person)
        else
          @person = Person.can_login?(params[:email_or_username])
          if @person
            if Rails.env.staging? && ENV['FAVORITE_CHARACTER'].present? && (params[:password] == ENV['FAVORITE_CHARACTER'])
              @person = auto_login(@person)
            else
              @person = login(@person.email, params[:password]) if @person
            end
          end
          if @person.nil?
            render_error(_('Invalid login.'))
            return
          end
        end
        return_the @person
      end

      # **
      # @api {delete} /session Log someone out.
      # @apiName DestroySession
      # @apiGroup Sessions
      # @apiVersion 1.0.0
      #
      # @apiDescription
      #   This is used to log someone out.
      # *

      def destroy
        logout
        cookies.delete :_fanlink_session
        render body: nil, status: :ok
      end
    end
  end
end
