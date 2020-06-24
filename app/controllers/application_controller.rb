# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :require_login

  before_action :set_current_user

  def set_current_user
    Person.current_user = current_user
  end

  def status
    head :ok
  end
  skip_before_action :require_login, only: %i[status]

  #
  # Respond to an API request with an object. If the object is invalid
  # (i.e. responds to `valid?` and `valid?` is false) then we will send
  # back `{ :errors => obj.errors }` in JSON with a 402 response code;
  # otherwise we will respond by rendering the current action's view.
  #
  # You can use the `:using` option to specify a different action. A common
  # use would be something like this:
  #
  #     return_the @thing, :using => :show
  #
  # This is a homebrew replacement for `respond_with` which disappeared
  # in Rails4.
  #
  # @param [Object] obj
  #   The object to respond with.
  # @param [Hash] opts
  #   Options. We currently only have a `:using` option that defaults
  #   to the current `params[:action]` value.
  #
  def return_the(obj, opts = {})
    opts = { using: params[:action], handler: 'jbuilder', postfix: 'base' }.merge(opts)
    # /api\/(?<version>v[0-9]+)\/(?<template>\w+)/ =~ params[:controller] #ActAsApi
    #
    # If `obj` doesn't know what `valid?` means then we're presumably
    # dealing with a simple Hash or something and such things are presumably
    # okay. If `obj.destroyed?` then we're presumably responding to a
    # successful DESTROY call. The `valid?` should should take care of
    # everything else.
    #
    if obj.nil?
      render_404(_('Not found.')) && (return)
      # return
    elsif (obj.respond_to?(:valid?) && !obj.valid?)
      render_422(obj.errors) && (return)
      # return
    elsif (!obj.respond_to?(:valid?) || obj.destroyed? || obj.valid?)
      render action: opts[:using], formats: %i[json], handlers: opts[:handler] && return
    end
  end

  protected

  def require_login
    authenticate!
    super
  end

  def authenticate!
    return if authorization_header.nil?

    payload, header = TokenProvider.valid?(token)
    user = Person.find_by(id: payload['user_id'])
    unless user.nil? || user.terminated?
      auto_login(user)
      user.update_column(:last_activity_at, Time.zone.now)
    end
  rescue JWT::DecodeError
  end

  def token
    @jwt_token ||= authorization_header.split(' ').last
  end

  private

  def authorization_header
    request.headers['Authorization']
  end
end
