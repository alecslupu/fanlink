# frozen_string_literal: true

module Api
  module V4
    class SessionController < Api::V3::SessionController
      prepend_before_action :logout, only: [:create, :token]
      before_action :set_product, only: [:create, :token]

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
        if params['facebook_auth_token'].present?
          @person = Person.for_facebook_auth_token(params['facebook_auth_token'])
          return render_422 _('Unable to find user from token. Likely a problem contacting Facebook.') if @person.nil?
          return render_401 _('Your account has been banned.') if @person.terminated
          return render_401 _('This account is not authorized.') unless @person.authorized
          auto_login(@person)
        else
          @person = Person.can_login?(params[:email_or_username])
          if @person
            if Rails.env.staging? && ENV['FAVORITE_CHARACTER'].present? && (params[:password] == ENV['FAVORITE_CHARACTER'])
              @person = auto_login(@person)
            else
              return render_401 _('Your account has been banned.') if @person.terminated
              return render_401 _('This account is not authorized.') unless @person.authorized
              @person = login(@person.email, params[:password]) if @person
            end
          end
          return render_422 _('Invalid login.') if @person.nil?
        end
        return_the @person, handler: tpl_handler
      end

      def token
        @person = nil
        if params['facebook_auth_token'].present?
          @person = Person.for_facebook_auth_token(params['facebook_auth_token'])
          return render_422 _('Unable to find user from token. Likely a problem contacting Facebook.') if @person.nil?
          return render_401 _('Your account has been banned.') if @person.terminated
          return render_401 _('This account is not authorized.') unless @person.authorized
          auto_login(@person)
        else
          @person = Person.can_login?(params[:email_or_username])
          if @person.present?
            return render_401 _('Your account has been banned.') if @person.terminated
            return render_401 _('This account is not authorized.') unless @person.authorized
            @person = login(@person.email, params[:password]) if @person
          end
          return render_422 _('Invalid login.') if @person.nil?
        end
        return_the @person, handler: tpl_handler, using: :create
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
